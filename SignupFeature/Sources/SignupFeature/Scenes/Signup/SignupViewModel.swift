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
    
    @Published
    var username: String = ""
    
    @Published
    var name: String = ""
    
    @Published
    var password: String = ""
    
    @Published
    var retypedPassword: String = ""
    
    public var isSignupEnabled: Bool {
        emailError == nil
    }
    
    private let signupUseCase: SignupUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(signupUseCase: SignupUseCaseProviding) {
        self.signupUseCase = signupUseCase
        
        forward(_email.emailPublisher, to: signupUseCase.email)
            .store(in: &subscriptions)
        
        forward($username, to: signupUseCase.username)
            .store(in: &subscriptions)
        
        forward($name, to: signupUseCase.name)
            .store(in: &subscriptions)
        
        forward($password, to: signupUseCase.password)
            .store(in: &subscriptions)
        
        _email.emailErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] emailValueError in
                self?.emailError = emailValueError
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
