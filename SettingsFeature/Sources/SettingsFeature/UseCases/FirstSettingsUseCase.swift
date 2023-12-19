//
//  FirstSettingsUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol FirstSettingsUseCaseProviding {
    
    func showSecondSettingsScene()
}

public class FirstSettingsUseCase: FirstSettingsUseCaseProviding {
    
    public init() {
        
    }
    
    public func showSecondSettingsScene() {
        
    }
    
}

#if DEBUG

public class PreviewFirstSettingsUseCase: FirstSettingsUseCaseProviding {
    
    public func showSecondSettingsScene() {}
}

#endif
