//
//  EntryPointUseCase.swift
//
//
//  Created by Themis Makedas on 25/12/23.
//

import Foundation
import ApplicationLayer

public protocol EntryPointUseCaseProviding {
    
    func showHomeScene()
}

public class EntryPointUseCase: EntryPointUseCaseProviding {
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
    }
    
    public func showHomeScene() {
        homeRouter.showHomeScene()
    }
    
}

#if DEBUG

public class PreviewEntryPointUseCase: EntryPointUseCaseProviding {
    
    public func showHomeScene() {}
}

#endif
