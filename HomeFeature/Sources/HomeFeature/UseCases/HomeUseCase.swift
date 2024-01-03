//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer

public protocol HomeUseCaseProviding {
    
    func showProfileScene()
}

public class HomeUseCase: HomeUseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func showProfileScene() {
        homeRouter.showUserProfileScene()
//        homeRouter.popScene()
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public func showProfileScene() {}
}

#endif
