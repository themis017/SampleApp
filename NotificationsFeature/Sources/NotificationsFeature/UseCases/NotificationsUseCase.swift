//
//  NotificationsUseCase.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol NotificationsUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var appDataUsername: Observable<String> { get }
    
    func nextAction()
}

public class NotificationsUseCase: NotificationsUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let notificationsRouter: any NotificationsRouting
    
    public init(notificationsRouter: any NotificationsRouting) {
        
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
//        self.appDataUsername = Observable(initialValue: AppData.username)
        self.appDataUsername = Observable(initialValue: AppData.shared.value(of: .username) ?? "")
        
        self.notificationsRouter = notificationsRouter
        
        AppData.shared
            .usernamePublisher
            .sink { newValue in
                print("# username: \(newValue)")
            }
            .store(in: &subscriptions)
    }
    
    public func nextAction() {
//        notificationsRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
}

#if DEBUG

public class PreviewNotificationsUseCase: NotificationsUseCaseProviding {
    
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
