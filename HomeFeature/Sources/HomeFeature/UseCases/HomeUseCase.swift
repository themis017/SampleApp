//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol HomeUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var appDataUsername: Observable<String> { get }
    
    func showProfileScene()
}

public class HomeUseCase: HomeUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: AppData.username)
        
        self.homeRouter = homeRouter
    }
    
    public func showProfileScene() {
        homeRouter.showUserProfileScene()
//        homeRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public var appDataUsername: Observable<String>
    
    init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: "")
    }
    
    public func showProfileScene() {}
}

#endif
