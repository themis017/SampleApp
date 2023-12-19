//
//  SecondSettingsUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol SecondSettingsUseCaseProviding {
    
    func dismiss()
}

public class SecondSettingsUseCase: SecondSettingsUseCaseProviding {
    
    public init() {
        
    }
    
    public func dismiss() {
        
    }
    
}

#if DEBUG

public class PreviewSecondSettingsUseCase: SecondSettingsUseCaseProviding {
    
    public func dismiss() {}
}

#endif
