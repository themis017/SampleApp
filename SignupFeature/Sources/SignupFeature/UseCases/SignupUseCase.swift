//
//  SignupUseCase.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol SignupUseCaseProviding {
    
    var email: Observable<String> { get }
    var username: Observable<String> { get }
    var name: Observable<String> { get }
    var password: Observable<String> { get }
    
    func signup()
    func dismiss()
}

public class SignupUseCase: SignupUseCaseProviding {
    
    public let email: Observable<String>
    public let username: Observable<String>
    public let name: Observable<String>
    public let password: Observable<String>
    
    private let signupRouter: any SignupRouting
    
    public init(signupRouter: any SignupRouting) {
        self.signupRouter = signupRouter
        
        self.email = Observable(initialValue: "")
        self.username = Observable(initialValue: "")
        self.name = Observable(initialValue: "")
        self.password = Observable(initialValue: "")
    }
    
    public func signup() {
        AppData.shared.save(true, to: .enableAutoLogin)
        signupRouter.showMainScene()
    }
    
    public func dismiss() {
        signupRouter.popScene(animated: true)
    }
    
}

#if DEBUG

public class PreviewSignupUseCase: SignupUseCaseProviding {
    
    public let email: Observable<String>
    public let username: Observable<String>
    public let name: Observable<String>
    public let password: Observable<String>
    
    init() {
        self.email = Observable(initialValue: "")
        self.username = Observable(initialValue: "")
        self.name = Observable(initialValue: "")
        self.password = Observable(initialValue: "")
    }
    
    public func signup() {}
    public func dismiss() {}
}

#endif
