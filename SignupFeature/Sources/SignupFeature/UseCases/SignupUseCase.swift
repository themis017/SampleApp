//
//  SignupUseCase.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import ApplicationLayer

public protocol SignupUseCaseProviding {
    
    func showMainScene()
    func dismiss()
}

public class SignupUseCase: SignupUseCaseProviding {
    
    private let signupRouter: any SignupRouting
    
    public init(signupRouter: any SignupRouting) {
        self.signupRouter = signupRouter
    }
    
    public func showMainScene() {
        signupRouter.showMainScene()
    }
    
    public func dismiss() {
        signupRouter.popScene(animated: true)
    }
    
}

#if DEBUG

public class PreviewSignupUseCase: SignupUseCaseProviding {
    
    public func showMainScene() {}
    public func dismiss() {}
}

#endif
