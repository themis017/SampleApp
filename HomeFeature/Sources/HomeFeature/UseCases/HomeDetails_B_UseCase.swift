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
    
    func nextAction()
}

public class HomeDetails_B_UseCase: HomeDetails_B_UseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func nextAction() {
//        homeRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
}

#if DEBUG

public class PreviewHomeDetails_B_UseCase: HomeDetails_B_UseCaseProviding {
    
    public init() {
    
    }
    
    public func nextAction() {}
}

#endif
