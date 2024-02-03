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
    var isValidatingEmail: Observable<Bool> { get }
    var username: Observable<String> { get }
    var isValidatingUsername: Observable<Bool> { get }
    var name: Observable<String> { get }
    var password: Observable<String> { get }
    
    func signup()
    func dismiss()
    func validateEmail()
    func validateUsername()
}

public class SignupUseCase: SignupUseCaseProviding {
    
    public let email: Observable<String>
    public let isValidatingEmail: Observable<Bool>
    public let username: Observable<String>
    public let isValidatingUsername: Observable<Bool>
    public let name: Observable<String>
    public let password: Observable<String>
    
    private let signupRouter: any SignupRouting
    
    public init(signupRouter: any SignupRouting) {
        self.signupRouter = signupRouter
        
        self.email = Observable(initialValue: "")
        self.isValidatingEmail = Observable(initialValue: false)
        self.username = Observable(initialValue: "")
        self.isValidatingUsername = Observable(initialValue: false)
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
    
    @MainActor
    public func validateEmail() {
        guard email.value.isNotEmpty() else {
            return
        }
        
        isValidatingEmail.value = true
        
        // MARK: Peform validation request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isValidatingEmail.value = false
        }
    }
    
    @MainActor
    public func validateUsername() {
        guard username.value.isNotEmpty() else {
            return
        }
        
        isValidatingUsername.value = true
        
        // MARK: Peform validation request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isValidatingUsername.value = false
        }
    }
}

#if DEBUG

public class PreviewSignupUseCase: SignupUseCaseProviding {
    
    public let email: Observable<String>
    public let isValidatingEmail: Observable<Bool>
    public let username: Observable<String>
    public let isValidatingUsername: Observable<Bool>
    public let name: Observable<String>
    public let password: Observable<String>
    
    init() {
        self.email = Observable(initialValue: "")
        self.isValidatingEmail = Observable(initialValue: false)
        self.username = Observable(initialValue: "")
        self.isValidatingUsername = Observable(initialValue: false)
        self.name = Observable(initialValue: "")
        self.password = Observable(initialValue: "")
    }
    
    public func signup() {}
    public func dismiss() {}
    public func validateEmail() {}
    public func validateUsername() {}
}

#endif
