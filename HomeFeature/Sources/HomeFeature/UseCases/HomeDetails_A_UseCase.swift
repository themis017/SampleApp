//
//  HomeDetails_A_UseCase.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol HomeDetails_A_UseCaseProviding {
    
    func dismiss(animated: Bool)
    func nextAction()
    func showUpload()
    func showPath(for selectedTab: TabBarCategory)
}

public class HomeDetails_A_UseCase: HomeDetails_A_UseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func dismiss(animated: Bool) {
        homeRouter.popScene(animated: animated)
    }
    
    public func nextAction() {
        homeRouter.showHomeDetails_B_Scene()
    }
    
    public func showUpload() {
        homeRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {        
        if selectedTab == .home {
            homeRouter.dismissToRoot(for: .home)
        } else {
            let selectedTabEvent = SelectedTabEvent()
            selectedTabEvent.userInfo["tab"] = selectedTab
            EventPipeline.shared.send(selectedTabEvent)
            
            homeRouter.showPath(for: selectedTab)
        }
    }
}

#if DEBUG

public class PreviewHomeDetails_A_UseCase: HomeDetails_A_UseCaseProviding {
    
    public init() {}
    
    public func dismiss(animated: Bool) {}
    public func nextAction() {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
