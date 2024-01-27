//
//  EntryPointUseCase.swift
//
//
//  Created by Themis Makedas on 25/12/23.
//

import Foundation
import ApplicationLayer

public protocol EntryPointUseCaseProviding {
    
    func showMainScene()
}

public class EntryPointUseCase: EntryPointUseCaseProviding {
    
    private let mainRouter: any MainRouting
    
    public init(mainRouter: any MainRouting) {
        self.mainRouter = mainRouter
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.mainRouter.showMainScene()
        }
    }
    
    public func showMainScene() {
        mainRouter.showMainScene()
//        mainRouter.showHomeScene()
    }
    
}

#if DEBUG

public class PreviewEntryPointUseCase: EntryPointUseCaseProviding {
    
    public func showMainScene() {}
}

#endif
