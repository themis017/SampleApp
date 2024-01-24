//
//  UserProfile_A_UseCase.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol UserProfile_A_UseCaseProviding {
    
    func dismiss()
    func nextAction()
    func showPath(for selectedTab: TabBarCategory)
}

public class UserProfile_A_UseCase: UserProfile_A_UseCaseProviding {
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        self.userProfileRouter = userProfileRouter
    }
    
    public func dismiss() {
        userProfileRouter.popScene()
    }
    
    public func nextAction() {
        userProfileRouter.showUserProfile_B_Scene()
//        userProfileRouter.popScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        AppData.shared.save(selectedTab, to: .selectedTab)
        userProfileRouter.showPath(for: selectedTab)
    }
}

#if DEBUG

public class PreviewUserProfile_A_UseCase: UserProfile_A_UseCaseProviding {
    
    public init() {
    
    }
    
    public func dismiss() {}
    public func nextAction() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
