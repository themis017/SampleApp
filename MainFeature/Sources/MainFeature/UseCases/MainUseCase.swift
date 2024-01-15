//
//  MainUseCase.swift
//
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol MainUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var appDataUsername: Observable<String> { get }
    
    func nextAction()
}

public class MainUseCase: MainUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let mainRouter: any MainRouting
    
    public init(mainRouter: any MainRouting) {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
//        self.appDataUsername = Observable(initialValue: AppData.username)
        self.appDataUsername = Observable(initialValue: AppData.shared.value(of: .username) ?? "")
        
        self.mainRouter = mainRouter
        
        AppData.shared
            .usernamePublisher
            .sink { newValue in
                print("# username: \(newValue)")
            }
            .store(in: &subscriptions)
    }
    
    public func nextAction() {
//        mainRouter.showUserProfileScene()
//        homeRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
}

#if DEBUG

public class PreviewMainUseCase: MainUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public var appDataUsername: Observable<String>
    
    init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.appDataUsername = Observable(initialValue: "")
    }
    
    public func nextAction() {}
}

#endif
