//
//  OtherUserProfileViewModel.swift
//
//
//  Created by Themis Makedas on 12/2/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class OtherUserProfileViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss
        case follow
        case unfollow
    }
    
    var selectedTab: TabBarCategory
    
    @Published
    var userProfile: UserProfile?
    
    private let otherUserProfileUseCase: OtherUserProfileUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(otherUserProfileUseCase: OtherUserProfileUseCaseProviding) {
        self.otherUserProfileUseCase = otherUserProfileUseCase
        
        self.selectedTab = otherUserProfileUseCase.selectedTab.value
        self.userProfile = otherUserProfileUseCase.userProfile.value
        
        bind(\.userProfile, to: otherUserProfileUseCase.userProfile)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            guard tabCategory != .upload else {
                otherUserProfileUseCase.showUpload()
                return
            }
            
            otherUserProfileUseCase.showPath(for: tabCategory)
        case .dismiss:
            otherUserProfileUseCase.dismiss()
        case .follow:
            otherUserProfileUseCase.follow()
        case .unfollow:
            otherUserProfileUseCase.unfollow()
        }
    }
}

#if DEBUG

public extension OtherUserProfileViewModel {
    
    static func previewViewModel() -> OtherUserProfileViewModel {
        let previewUseCase = PreviewOtherUserProfileUseCase()
        return OtherUserProfileViewModel(otherUserProfileUseCase: previewUseCase)
    }
}

#endif
