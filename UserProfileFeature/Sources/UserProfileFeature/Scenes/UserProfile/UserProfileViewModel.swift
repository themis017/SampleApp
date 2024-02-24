//
//  UserProfileViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UserProfileViewModel: ViewModel {
    
    public enum Action {
        case refresh
        case editProfile
        case logout
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var isCurrentlyRefreshing: Bool
    
    @Published
    var showingLogoutAlert = false
    
    private let userProfileUseCase: UserProfileUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(userProfileUseCase: UserProfileUseCaseProviding) {
        self.userProfileUseCase = userProfileUseCase
        self.userProfile = userProfileUseCase.userProfile.value
        self.isCurrentlyRefreshing = userProfileUseCase.isCurrentlyRefreshing.value
        
        bind(\.userProfile, to: userProfileUseCase.userProfile)
            .store(in: &subscriptions)
        
        bind(\.isCurrentlyRefreshing, to: userProfileUseCase.isCurrentlyRefreshing)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .refresh:
            userProfileUseCase.refresh()
        case .editProfile:
            userProfileUseCase.showEditProfile()
        case .logout:
            userProfileUseCase.logout()
        }
    }
}

#if DEBUG

public extension UserProfileViewModel {
    
    static func previewViewModel() -> UserProfileViewModel {
        let previewUseCase = PreviewUserProfileUseCase()
        return UserProfileViewModel(userProfileUseCase: previewUseCase)
    }
}

#endif
