//
//  EntryPointUseCase.swift
//
//
//  Created by Themis Makedas on 25/12/23.
//

import Foundation
import ApplicationLayer

public protocol EntryPointUseCaseProviding {
    
    func showSignupScene()
    func showLoginScene()
}

public class EntryPointUseCase: EntryPointUseCaseProviding {
    
    private let mainRouter: any MainRouting
    
    public init(mainRouter: any MainRouting) {
        self.mainRouter = mainRouter
    }
    
    public func showSignupScene() {
        mainRouter.showSignupScene()
    }
    
    public func showLoginScene() {
        mainRouter.showLoginScene()
    }
    
}

#if DEBUG

public class PreviewEntryPointUseCase: EntryPointUseCaseProviding {
    
    public func showSignupScene() {}
    public func showLoginScene() {}
}

#endif
