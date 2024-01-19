//
//  UserProfile_B_UseCase.swift
//  
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol UserProfile_B_UseCaseProviding {
    
    func nextAction()
}

public class UserProfile_B_UseCase: UserProfile_B_UseCaseProviding {
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        self.userProfileRouter = userProfileRouter
    }
    
    public func nextAction() {
//        userProfileRouter.popScene()
    }
    
}

#if DEBUG

public class PreviewUserProfile_B_UseCase: UserProfile_B_UseCaseProviding {
    
    public init() {
    
    }
    
    public func nextAction() {}
}

#endif
