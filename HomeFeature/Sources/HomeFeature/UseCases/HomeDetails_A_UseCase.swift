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
    
}

#if DEBUG

public class PreviewHomeDetails_A_UseCase: HomeDetails_A_UseCaseProviding {
    
    public init() {
    
    }
    
    public func nextAction() {}
}

#endif
