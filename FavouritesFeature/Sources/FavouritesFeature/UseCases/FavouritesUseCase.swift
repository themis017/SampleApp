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
    
    var userProfile: Observable<UserProfile?> { get }
    
    func nextAction()
}

public class FavouritesUseCase: FavouritesUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let userProfile: Observable<UserProfile?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let favouritesRouter: any FavouritesRouting
    
    public init(favouritesRouter: any FavouritesRouting) {
        
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        
        self.favouritesRouter = favouritesRouter
        
        AppData.shared
            .userProfilePublisher
            .sink { newValue in
                print("# userProfile: \(newValue)")
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
    
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: UserProfile.user_1)
    }
    
    public func nextAction() {}
}

#endif
