//
//  MainViewModel.swift
//
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer
import HomeFeature
import UserProfileFeature
import SettingsFeature

@MainActor
public class MainViewModel: ViewModel {
    
    public enum Action {
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    private let mainUseCase: MainUseCaseProviding
    
    public let homeViewModel: HomeViewModel
    public let userProfileViewModel: UserProfileViewModel
    public let settingsViewModel: SettingsViewModel
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(mainUseCase: MainUseCaseProviding,
                homeUseCase: HomeUseCaseProviding,
                userProfileUseCase: UserProfileUseCaseProviding,
                settingsUseCase: SettingsUseCaseProviding) {
        
        self.selectedTab = mainUseCase.selectedTab.value
        self.randomProperty = mainUseCase.randomProperty.value
        self.mainUseCase = mainUseCase
        
        self.homeViewModel = HomeViewModel(homeUseCase: homeUseCase)
        self.userProfileViewModel = UserProfileViewModel(userProfileUseCase: userProfileUseCase)
        self.settingsViewModel = SettingsViewModel(settingsUseCase: settingsUseCase)
        
        bind(\.selectedTab, to: mainUseCase.selectedTab)
            .store(in: &subscriptions)
        
        bind(\.randomProperty, to: mainUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: mainUseCase.randomText)
            .store(in: &subscriptions)
        
        $selectedTab
            .dropFirst()
            .sink { newValue in
                print("### selectedTab: \(newValue)")
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            mainUseCase.nextAction()
        }
    }
}

#if DEBUG

public extension MainViewModel {
    
    static func previewViewModel() -> MainViewModel {
        let previewMainUseCase = PreviewMainUseCase()
        let previewHomeUseCase = PreviewHomeUseCase()
        let previewUserProfileUseCase = PreviewUserProfileUseCase()
        let previewSettingsUseCase = PreviewSettingsUseCase()
        
        return MainViewModel(
            mainUseCase: previewMainUseCase,
            homeUseCase: previewHomeUseCase,
            userProfileUseCase: previewUserProfileUseCase,
            settingsUseCase: previewSettingsUseCase)
    }
}

#endif
