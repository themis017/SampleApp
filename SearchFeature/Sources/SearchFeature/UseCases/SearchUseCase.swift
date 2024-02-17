//
//  SearchUseCase.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol SearchUseCaseProviding {
    
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var userProfile: Observable<UserProfile?> { get }
    
    func nextAction()
}

public class SearchUseCase: SearchUseCaseProviding {
    
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let userProfile: Observable<UserProfile?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let searchRouter: any SearchRouting
    
    public init(searchRouter: any SearchRouting) {
        
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        
        self.searchRouter = searchRouter
        
        AppData.shared
            .userProfilePublisher
            .sink { [weak self] newValue in
                self?.userProfile.value = newValue
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

public class PreviewSearchUseCase: SearchUseCaseProviding {
    
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
    }
    
    public func nextAction() {}
}

#endif
