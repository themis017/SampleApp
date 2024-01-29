//
//  LoginUseCase.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import ApplicationLayer

public protocol LoginUseCaseProviding {
    
    func showMainScene()
    func dismiss()
}

public class LoginUseCase: LoginUseCaseProviding {
    
    private let loginRouter: any LoginRouting
    
    public init(loginRouter: any LoginRouting) {
        self.loginRouter = loginRouter
    }
    
    public func showMainScene() {
        loginRouter.showMainScene()
    }
    
    public func dismiss() {
        loginRouter.popScene(animated: true)
    }
    
}

#if DEBUG

public class PreviewLoginUseCase: LoginUseCaseProviding {
    
    public func showMainScene() {}
    public func dismiss() {}
}

#endif
