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
    
    func dismiss(animated: Bool)
    func nextAction()
    func showUpload() 
    func showPath(for selectedTab: TabBarCategory)
}

public class UserProfile_B_UseCase: UserProfile_B_UseCaseProviding {
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        self.userProfileRouter = userProfileRouter
    }
    
    public func dismiss(animated: Bool) {
        userProfileRouter.popScene(animated: animated)
    }
    
    public func nextAction() {
//        userProfileRouter.popScene()
    }
    
    public func showUpload() {
        userProfileRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {        
        if selectedTab == .profile {
            userProfileRouter.dismissToRoot(for: .profile)
        } else {
            let selectedTabEvent = SelectedTabEvent()
            selectedTabEvent.userInfo["tab"] = selectedTab
            EventPipeline.shared.send(selectedTabEvent)
            
            userProfileRouter.showPath(for: selectedTab)
        }
    }
}

#if DEBUG

public class PreviewUserProfile_B_UseCase: UserProfile_B_UseCaseProviding {
    
    public init() {
    
    }
    
    public func dismiss(animated: Bool) {}
    public func nextAction() {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
