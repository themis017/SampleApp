//
//  UserProfileUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol UserProfileUseCaseProviding {
    
    func showSettingsScene()
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    public init() {
        
    }
    
    public func showSettingsScene() {
        
    }
    
}

#if DEBUG

public class PreviewUserProfileUseCase: UserProfileUseCaseProviding {
    
    public func showSettingsScene() {}
}

#endif
