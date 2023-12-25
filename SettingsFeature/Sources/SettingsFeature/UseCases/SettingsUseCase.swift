//
//  SettingsUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer

public protocol SettingsUseCaseProviding {
    
    func showSecondSettingsScene()
}

public class SettingsUseCase: SettingsUseCaseProviding {
    
    private let settingsRouter: any SettingsRouting
    
    public init(settingsRouter: any SettingsRouting) {
        self.settingsRouter = settingsRouter
    }
    
    public func showSecondSettingsScene() {
        print("TODO")
    }
    
}

#if DEBUG

public class PreviewSettingsUseCase: SettingsUseCaseProviding {
    
    public func showSecondSettingsScene() {}
}

#endif
