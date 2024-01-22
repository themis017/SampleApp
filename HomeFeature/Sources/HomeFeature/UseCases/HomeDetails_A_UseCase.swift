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
    
    func nextAction()
    func showPath(for selectedTab: TabBarCategory)
}

public class HomeDetails_A_UseCase: HomeDetails_A_UseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func nextAction() {
        homeRouter.showHomeDetails_B_Scene()
//        homeRouter.popScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        AppData.shared.save(selectedTab, to: .selectedTab)
        homeRouter.showPath(for: selectedTab)
    }
    
}

#if DEBUG

public class PreviewHomeDetails_A_UseCase: HomeDetails_A_UseCaseProviding {
    
    public init() {
    
    }
    
    public func nextAction() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
