//
//  UserProfileUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer

public protocol UserProfileUseCaseProviding {
    
    func showSettingsScene()
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    private let userProfileRouter: UserProfileRouting
    
    public init(userProfileRouter: UserProfileRouting) {
        self.userProfileRouter = userProfileRouter
    }
    
    public func showSettingsScene() {
        userProfileRouter.showSettings()
    }
    
}

#if DEBUG

public class PreviewUserProfileUseCase: UserProfileUseCaseProviding {
    
    public func showSettingsScene() {}
}

#endif
