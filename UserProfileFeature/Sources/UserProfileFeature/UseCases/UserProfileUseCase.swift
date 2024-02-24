//
//  UserProfileUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol UserProfileUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    var isCurrentlyRefreshing: Observable<Bool> {get }
    
    func refresh()
    func showEditProfile()
    func logout()
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let isCurrentlyRefreshing: Observable<Bool>
    
    private let userProfileRouter: any UserProfileRouting
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.isCurrentlyRefreshing = Observable(initialValue: false)
        
        AppData.shared
            .userProfilePublisher
            .sink { [weak self] newValue in
                self?.userProfile.value = newValue
            }
            .store(in: &subscriptions)
        
        if userProfile.value == nil {
            loadUserProfile()
        }
    }
    
    private func loadUserProfile() {
        userProfile.value = UserProfile.principalUser
    }
    
    @MainActor
    public func refresh() {
        guard !isCurrentlyRefreshing.value else {
            return
        }
        
        isCurrentlyRefreshing.value = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isCurrentlyRefreshing.value = false
            }
    }
    
    public func showEditProfile() {
        userProfileRouter.showEditProfileScene()
    }
    
    public func logout() {
        AppData.shared.save(false, to: .enableAutoLogin)
        userProfileRouter.showEntryPointScene()
    }
}

#if DEBUG

public class PreviewUserProfileUseCase: UserProfileUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var isCurrentlyRefreshing: Observable<Bool>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.isCurrentlyRefreshing = Observable(initialValue: false)
    }
    
    public func refresh() {}
    public func showEditProfile() {}
    public func logout() {}
}

#endif
