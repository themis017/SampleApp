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
    
    func showEditProfile()
    func logout()
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    
    private let userProfileRouter: any UserProfileRouting
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        
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
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
    }
    
    public func showEditProfile() {}
    public func logout() {}
}

#endif
