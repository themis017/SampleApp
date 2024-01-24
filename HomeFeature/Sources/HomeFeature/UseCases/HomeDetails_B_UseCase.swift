//
//  HomeDetails_B_UseCase.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol HomeDetails_B_UseCaseProviding {
    
    func dismiss()
    func nextAction()
    func showPath(for selectedTab: TabBarCategory)
}

public class HomeDetails_B_UseCase: HomeDetails_B_UseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func dismiss() {
        homeRouter.popScene()
    }
    
    public func nextAction() {
//        homeRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
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

public class PreviewHomeDetails_B_UseCase: HomeDetails_B_UseCaseProviding {
    
    public init() {
    
    }
    
    public func dismiss() {}
    public func nextAction() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
