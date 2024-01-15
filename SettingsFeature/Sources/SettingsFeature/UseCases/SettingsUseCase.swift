//
//  SettingsUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol SettingsUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    func showSecondSettingsScene()
}

public class SettingsUseCase: SettingsUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    private let settingsRouter: any SettingsRouting
    
    public init(settingsRouter: any SettingsRouting) {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.settingsRouter = settingsRouter
    }
    
    public func showSecondSettingsScene() {
        print("TODO")
    }
    
}

#if DEBUG

public class PreviewSettingsUseCase: SettingsUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
    }
    
    public func showSecondSettingsScene() {}
}

#endif
