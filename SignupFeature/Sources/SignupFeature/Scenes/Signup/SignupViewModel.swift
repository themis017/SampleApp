//
//  SignupViewModel.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class SignupViewModel: ViewModel {
    
    public enum Action {
        case signup
        case dismiss
    }
    
    @EmailValidated
    var email: String = ""
    
    @Published
    var emailError: EmailValueError? = .emptyValue
    
    @UsernameValidated
    var username: String = ""
    
    @Published
    var usernameError: UsernameValueError? = .emptyValue
    
    @NameValidated
    var name: String = ""
    
    @Published
    var nameError: NameValueError? = .emptyValue
    
    @PasswordValidated
    var password: String = ""
    
    @Published
    var passwordError: PasswordValueError? = .emptyValue
    
    @PasswordValidated
    var retypedPassword: String = ""
    
    @Published
    var retypedPasswordError: PasswordValueError? = .emptyValue
    
    public var isSignupEnabled: Bool {
        emailError == nil &&
        usernameError == nil &&
        nameError == nil &&
        passwordError == nil &&
        retypedPasswordError == nil &&
        password == retypedPassword
    }
    
    private let signupUseCase: SignupUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(signupUseCase: SignupUseCaseProviding) {
        self.signupUseCase = signupUseCase
        
        forward(_email.emailPublisher, to: signupUseCase.email)
            .store(in: &subscriptions)
        
        forward(_username.usernamePublisher, to: signupUseCase.username)
            .store(in: &subscriptions)
        
        forward(_name.namePublisher, to: signupUseCase.name)
            .store(in: &subscriptions)
        
        forward(_password.passwordPublisher, to: signupUseCase.password)
            .store(in: &subscriptions)
        
        _email.emailErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] emailValueError in
                self?.emailError = emailValueError
            }
            .store(in: &subscriptions)
        
        _username.usernameErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] usernameValueError in
                self?.usernameError = usernameValueError
            }
            .store(in: &subscriptions)
        
        _name.nameErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] nameValueError in
                self?.nameError = nameValueError
            }
            .store(in: &subscriptions)
        
        _password.passwordErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] passwordValueError in
                self?.passwordError = passwordValueError
            }
            .store(in: &subscriptions)
        
        _retypedPassword.passwordErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] passwordValueError in
                self?.retypedPasswordError = passwordValueError
            }
            .store(in: &subscriptions)
        
        _password.passwordPublisher
            .combineLatest(_retypedPassword.passwordPublisher)
            .map( {($0, $1)} )
            .sink { [weak self] passwordValues in
                
                guard let self = self,
                      self.passwordError == nil,
                      self.retypedPasswordError == nil else {
                    
                    return
                }
                
                guard passwordValues.0 != passwordValues.1 else {
                    return
                }
                
                self.passwordError = .passwordNotMatch
                self.retypedPasswordError = .passwordNotMatch
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .signup:
            signupUseCase.signup()
        case .dismiss:
            signupUseCase.dismiss()
        }
    }
}

#if DEBUG

public extension SignupViewModel {
    
    static func previewViewModel() -> SignupViewModel {
        let previewUseCase = PreviewSignupUseCase()
        return SignupViewModel(signupUseCase: previewUseCase)
    }
}

#endif
