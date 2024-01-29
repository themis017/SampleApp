//
//  SignupViewModel.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation

@MainActor
public class SignupViewModel: ObservableObject {
    
    public enum Action {
        case showMain
        case dismiss
    }
    
    private let signupUseCase: SignupUseCaseProviding
   
    public init(signupUseCase: SignupUseCaseProviding) {
        self.signupUseCase = signupUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showMain:
            signupUseCase.showMainScene()
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
