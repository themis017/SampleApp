//
//  LoginViewModel.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation

@MainActor
public class LoginViewModel: ObservableObject {
    
    public enum Action {
        case showMain
        case dismiss
    }
    
    private let loginUseCase: LoginUseCaseProviding
   
    public init(loginUseCase: LoginUseCaseProviding) {
        self.loginUseCase = loginUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showMain:
            loginUseCase.showMainScene()
        case .dismiss:
            loginUseCase.dismiss()
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
