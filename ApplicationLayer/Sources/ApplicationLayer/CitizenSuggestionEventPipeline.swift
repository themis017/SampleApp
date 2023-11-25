//
//  CitizenSuggestionEventPipeline.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//


import UIKit
import Combine

public final class CitizenSuggestionEventPipeline {
    
    private struct UserProfileInfo: Hashable {
        let id: UUID
        let contactSyncingPreference: ContactSyncingPreference
        
        init(id: UUID,
             contactSyncingPreference: ContactSyncingPreference) {
            
            self.id = id
            self.contactSyncingPreference = contactSyncingPreference
        }
        
        init(examining userProfile: UserProfile) {
            self.init(id: userProfile.id, contactSyncingPreference: userProfile.contactSyncingPreference)
        }
    }
    
    public enum TrackedEvent {
        case invitedFriends
        case searchedCreators
        case searchedCitizens
    }
    
    @Persisted(store: .protectedFile(name: "banner_info"))
    private var syncContactsBanner: SyncContactsBanner?
    
    private let stateContainer: any StateContaining
    
    private let trackedEventSubject = PassthroughSubject<TrackedEvent, Never>()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let syncContactsBannerDisplaySubject = CurrentValueSubject<Bool, Never>(false)
    
    public var syncContactsBannerDisplayPublisher: AnyPublisher<Bool, Never> {
        syncContactsBannerDisplaySubject.eraseToAnyPublisher()
    }
    
    public init(stateContainer: any StateContaining) {
        self.stateContainer = stateContainer
        
        trackedEventSubject
            .sinkAsync { [weak self] newValue in
                await self?.updateDateForContactSyncingBannerIfNeeded()
            }
            .store(in: &subscriptions)
        
        $syncContactsBanner
            .filterNonNil()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.syncContactsBannerDisplaySubject.send(newValue.showBanner)
            }
            .store(in: &subscriptions)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .debounce(for: 1.0, scheduler: DispatchQueue.main)
            .replaceWithVoid()
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.checkTimeElapsed()
            }
            .store(in: &subscriptions)
        
        Task {
            await stateContainer.publisher(for: .userApplicationDataState)
                .map({ $0?.userProfile })
                .filterNonNil()
                .map({ UserProfileInfo(examining: $0) })
                .removeDuplicates()
                .sinkAsync { [weak self] newValue in
                    guard let self = self else {
                        return
                    }
                    
                    if self.syncContactsBanner == nil {
                        self.syncContactsBanner = SyncContactsBanner(id: newValue.id)
                    }

                    await self.displayContactSyncingBannerIfNeeded(of: newValue)
                }
                .store(in: &subscriptions)
        }
    }
    
    deinit {
        subscriptions.cancelAll()
    }
    
    public func receive(_ trackedEvent: TrackedEvent) {
        trackedEventSubject.send(trackedEvent)
    }
    
    public func notifyDismissPerformed() {
        guard let syncContactsBanner = self.syncContactsBanner else {
            return
        }
        
        self.syncContactsBanner = syncContactsBanner
            .changingLastDatePerformedAction(to: nil)
            .changingShowBanner(to: false)
            .changingFirstTimeShowBanner(to: false)
    }
    
    private func updateDateForContactSyncingBannerIfNeeded() async {
        
        guard let userApplicationData = await stateContainer.value(for: .userApplicationDataState),
              userApplicationData.userProfile.contactSyncingPreference == .disabled,
              let syncContactsBanner = syncContactsBanner,
              syncContactsBanner.lastDatePerformedAction == nil,
              !syncContactsBanner.showBanner else {
            return
        }
        
        self.syncContactsBanner = syncContactsBanner.changingLastDatePerformedAction(to: Date())
    }
    
    private func displayContactSyncingBannerIfNeeded(of userProfile: UserProfileInfo) async {
        guard let syncContactsBanner = syncContactsBanner else {
            return
        }
        
        guard userProfile.contactSyncingPreference == .disabled else {
            self.syncContactsBanner = syncContactsBanner
                .changingLastDatePerformedAction(to: nil)
                .changingShowBanner(to: false)
            
            return
        }
        
        guard syncContactsBanner.lastDatePerformedAction != nil else {
            let showBanner = syncContactsBanner.firstTimeShowSyncContactBanner ? true : syncContactsBanner.showBanner

            self.syncContactsBanner = syncContactsBanner
                .changingShowBanner(to: showBanner)

            return
        }
        
        checkTimeElapsed()
    }
    
    private func checkTimeElapsed() {
        guard let syncContactsBanner = syncContactsBanner,
              let lastDatePerformedAction = syncContactsBanner.lastDatePerformedAction else {
            return
        }
        
        let hasTimeElapsed = lastDatePerformedAction.hasElapsed(lifetime: .days(7))
        
        guard hasTimeElapsed else {
            return
        }
        
        self.syncContactsBanner = syncContactsBanner
            .changingLastDatePerformedAction(to: nil)
            .changingShowBanner(to: true)
    }
}
