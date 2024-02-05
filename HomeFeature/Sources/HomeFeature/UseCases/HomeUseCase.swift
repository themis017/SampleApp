//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol HomeUseCaseProviding {

    func randomAction()
}

public class HomeUseCase: HomeUseCaseProviding {
        
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func randomAction() {
        
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public init() {}
    
    public func randomAction() {}
}

#endif
