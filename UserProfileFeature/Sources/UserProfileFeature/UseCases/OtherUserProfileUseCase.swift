//
//  OtherUserProfileUseCase.swift
//  
//
//  Created by Themis Makedas on 9/2/24.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol OtherUserProfileUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    
    func logout()
}

public class OtherUserProfileUseCase: OtherUserProfileUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(user: UserReference,
                userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        self.userProfile = Observable(initialValue: nil)
        
        loadUserProfile(of: user)
    }
    
    private func loadUserProfile(of user: UserReference) {
        if user.id == "1" {
            userProfile.value = UserProfile.user_1
        } else if user.id == "2" {
            userProfile.value = UserProfile.user_2
        } else if user.id == "3" {
            userProfile.value = UserProfile.user_3
        } else if user.id == "4" {
            userProfile.value = UserProfile.user_4
        } else {
            userProfile.value = UserProfile.user_5
        }
    }
    
    public func logout() {
        AppData.shared.save(false, to: .enableAutoLogin)
        userProfileRouter.showEntryPointScene()
    }
}

#if DEBUG

public class PreviewOtherUserProfileUseCase: OtherUserProfileUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.user_1)
    }
    
    public func logout() {}
}

#endif
