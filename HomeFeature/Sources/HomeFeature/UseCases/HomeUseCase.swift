//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol HomeUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var appDataUsername: Observable<String> { get }
    
    func nextAction()
}

public class HomeUseCase: HomeUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
//        self.appDataUsername = Observable(initialValue: AppData.username)
        self.appDataUsername = Observable(initialValue: AppData.shared.value(of: .username) ?? "")
        
        self.homeRouter = homeRouter
        
        AppData.shared
            .usernamePublisher
            .sink { newValue in
                print("# username: \(newValue)")
            }
            .store(in: &subscriptions)
    }
    
    public func nextAction() {
        homeRouter.showHomeDetails_A_Scene()
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
    
    public init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: "")
    }
    
    public func nextAction() {}
}

#endif
