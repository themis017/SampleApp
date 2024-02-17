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
    
    var selectedTab: Observable<TabBarCategory> { get }
    var randomProperty: Observable<Int> { get }
    var randomText: Observable<String> { get }
    
    var userProfile: Observable<UserProfile?> { get }
    
    func nextAction()
    func showUpload()
    func showPath(for selectedTab: TabBarCategory)
}

public class MainUseCase: MainUseCaseProviding {
    
    public let selectedTab: Observable<TabBarCategory>
    public let randomProperty: Observable<Int>
    public let randomText: Observable<String>
    
    public let userProfile: Observable<UserProfile?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let mainRouter: any MainRouting
    
    public init(selectedTab: TabBarCategory,
                mainRouter: any MainRouting) {
        
        self.selectedTab = Observable(initialValue: selectedTab)
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        
        self.mainRouter = mainRouter
        
        AppData.shared
            .userProfilePublisher
            .sink { [weak self] newValue in
                self?.userProfile.value = newValue
            }
            .store(in: &subscriptions)
    }

    public func nextAction() {
//        mainRouter.showUserProfileScene()
//        homeRouter.popScene()
//        randomProperty.value += 1
//        print("randomText: \(randomText.value)")
    }
    
    public func showUpload() {
        mainRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        mainRouter.showPath(for: selectedTab)
    }
}

#if DEBUG

public class PreviewMainUseCase: MainUseCaseProviding {
    
    public var selectedTab: Observable<TabBarCategory>
    public var randomProperty: Observable<Int>
    public var randomText: Observable<String>
    
    public var userProfile: Observable<UserProfile?>
    
    init() {
        self.selectedTab = Observable(initialValue: .home)
        self.randomProperty = Observable(initialValue: 0)
        self.randomText = Observable(initialValue: "")
        
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
    }
    
    public func nextAction() {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
}

#endif
