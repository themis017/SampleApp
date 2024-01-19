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
    
    var appDataUsername: Observable<String> { get }
    
    func nextAction()
    func saveUsername(to username: String)
}

public class UserProfileUseCase: UserProfileUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: AppData.shared.value(of: .username) ?? "")
        
        self.userProfileRouter = userProfileRouter
    }
    
    public func nextAction() {
        userProfileRouter.showUserProfile_A_Scene()
    }
    
    public func saveUsername(to username: String) {
        defer {
            appDataUsername.value = username
        }
        
        AppData.shared.save(username, to: .username)
    }
    
}

#if DEBUG

public class PreviewUserProfileUseCase: UserProfileUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public var appDataUsername: Observable<String>
    
    public init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: "")
    }
    
    public func nextAction() {}
    public func saveUsername(to username: String) {}
}

#endif
