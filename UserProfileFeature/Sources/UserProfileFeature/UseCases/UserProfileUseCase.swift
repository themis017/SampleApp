//
//  UserProfileUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
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
    
    public init(userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        self.userProfile = Observable(initialValue: nil)
        
        loadUserProfile()
    }
    
    private func loadUserProfile() {
        userProfile.value = UserProfile.user_1
    }
    
    public func showEditProfile() {
        
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
        self.userProfile = Observable(initialValue: UserProfile.user_1)
    }
    
    public func showEditProfile() {}
    public func logout() {}
}

#endif
