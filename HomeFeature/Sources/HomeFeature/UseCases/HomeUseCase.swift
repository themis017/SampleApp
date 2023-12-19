//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol HomeUseCaseProviding {
    
    func showProfileScene()
}

public class HomeUseCase: HomeUseCaseProviding {
    
    public init() {
        
    }
    
    public func showProfileScene() {
        
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public func showProfileScene() {}
}

#endif
