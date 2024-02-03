//
//  LoginViewModel.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import Combine
import SwiftUI
import ApplicationLayer
import UILayer

@MainActor
public class LoginViewModel: ViewModel {
    
    public enum Action {
        case login
        case dismiss
        case focusedField(of: FocusedField?)
    }
    
    public enum FocusedField: CaseIterable {
        case username, password
    }
    
    @Published
    var focusedFields: Set<FocusedField> = Set()
    
    @UsernameValidated
    var username: String = ""
    
    @Published
    var usernameError: UsernameValueError?
    
    @PasswordValidated
    var password: String = ""
    
    @Published
    var passwordError: PasswordValueError?
    
    public var isLoginEnabled: Bool {
        usernameError == nil &&
        passwordError == nil &&
        focusedFields.count == FocusedField.allCases.count
    }
    
    private let loginUseCase: LoginUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(loginUseCase: LoginUseCaseProviding) {
        self.loginUseCase = loginUseCase
        
        forward(_username.usernamePublisher, to: loginUseCase.username)
            .store(in: &subscriptions)
        
        forward(_password.passwordPublisher, to: loginUseCase.password)
            .store(in: &subscriptions)
        
        _username.usernameErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] usernameValueError in
                self?.usernameError = usernameValueError
            }
            .store(in: &subscriptions)
        
        _password.passwordErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] passwordValueError in
                self?.passwordError = passwordValueError
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .login:
            loginUseCase.login()
        case .dismiss:
            loginUseCase.dismiss()
        case .focusedField(let focusField):
            guard let focusField = focusField else {
                return
            }
            
            focusedFields.insert(focusField)
        }
    }
}

#if DEBUG

public extension LoginViewModel {
    
    static func previewViewModel() -> LoginViewModel {
        let previewUseCase = PreviewLoginUseCase()
        return LoginViewModel(loginUseCase: previewUseCase)
    }
}

#endif
