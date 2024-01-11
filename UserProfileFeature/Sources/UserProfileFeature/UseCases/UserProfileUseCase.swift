//
//  UserProfileUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol UserProfileUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    func showSettingsScene()
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfileRouter = userProfileRouter
    }
    
    public func showSettingsScene() {
        userProfileRouter.showSettings()
    }
    
}

#if DEBUG

public class PreviewUserProfileUseCase: UserProfileUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
    }
    
    public func showSettingsScene() {}
}

#endif
