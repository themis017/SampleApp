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
    
    private let homeRouter: HomeRouting
    
    public init(homeRouter: HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func showProfileScene() {
        homeRouter.showUserProfileScene()
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public func showProfileScene() {}
}

#endif
