//
//  LoginUseCase.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol LoginUseCaseProviding {
    
    var username: Observable<String> { get }
    var password: Observable<String> { get }
    
    func login()
    func dismiss()
}

public class LoginUseCase: LoginUseCaseProviding {
    
    public let username: Observable<String>
    public let password: Observable<String>
    
    private let loginRouter: any LoginRouting
    
    public init(loginRouter: any LoginRouting) {
        self.loginRouter = loginRouter
        
        self.username = Observable(initialValue: "")
        self.password = Observable(initialValue: "")
    }
    
    public func login() {
        AppData.shared.save(true, to: .enableAutoLogin)
        loginRouter.showMainScene()
    }
    
    public func dismiss() {
        loginRouter.popScene(animated: true)
    }
    
}

#if DEBUG

public class PreviewLoginUseCase: LoginUseCaseProviding {
    
    public let username: Observable<String>
    public let password: Observable<String>
    
    init() {
        self.username = Observable(initialValue: "")
        self.password = Observable(initialValue: "")
    }
    
    public func login() {}
    public func dismiss() {}
}

#endif
