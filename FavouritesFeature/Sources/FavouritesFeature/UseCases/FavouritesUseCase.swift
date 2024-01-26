//
//  FavouritesUseCase.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol FavouritesUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var appDataUsername: Observable<String> { get }
    
    func nextAction()
}

public class FavouritesUseCase: FavouritesUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let appDataUsername: Observable<String>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let favouritesRouter: any FavouritesRouting
    
    public init(favouritesRouter: any FavouritesRouting) {
        
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
//        self.appDataUsername = Observable(initialValue: AppData.username)
        self.appDataUsername = Observable(initialValue: AppData.shared.value(of: .username) ?? "")
        
        self.favouritesRouter = favouritesRouter
        
        AppData.shared
            .usernamePublisher
            .sink { newValue in
                print("# username: \(newValue)")
            }
            .store(in: &subscriptions)
    }
    
    public func nextAction() {
//        favouritesRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
}

#if DEBUG

public class PreviewFavouritesUseCase: FavouritesUseCaseProviding {
    
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
