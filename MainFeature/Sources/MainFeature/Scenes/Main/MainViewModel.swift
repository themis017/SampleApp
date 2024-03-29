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
import SearchFeature
import FavouritesFeature
import UserProfileFeature

@MainActor
public class MainViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
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
    public let searchViewModel: SearchViewModel
    public let favouritesViewModel: FavouritesViewModel
    public let userProfileViewModel: UserProfileViewModel
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(mainUseCase: MainUseCaseProviding,
                homeUseCase: HomeUseCaseProviding,
                searchUseCase: SearchUseCaseProviding,
                favouritesUseCase: FavouritesUseCaseProviding,
                userProfileUseCase: UserProfileUseCaseProviding) {
        
        self.selectedTab = mainUseCase.selectedTab.value
        self.randomProperty = mainUseCase.randomProperty.value
        self.mainUseCase = mainUseCase
        
        self.homeViewModel = HomeViewModel(homeUseCase: homeUseCase)
        self.searchViewModel = SearchViewModel(searchUseCase: searchUseCase)
        self.favouritesViewModel = FavouritesViewModel(favouritesUseCase: favouritesUseCase)
        self.userProfileViewModel = UserProfileViewModel(userProfileUseCase: userProfileUseCase)
        
        bind(\.selectedTab, to: mainUseCase.selectedTab)
            .store(in: &subscriptions)
        
        bind(\.randomProperty, to: mainUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: mainUseCase.randomText)
            .store(in: &subscriptions)
        
        EventPipeline.shared
            .eventPublisher
            .receive(on: DispatchQueue.main)
            .filter({ $0.type == .selectedTab })
            .sink { [weak self] newValue in
                guard newValue.userInfo.keys.contains("tab"),
                   let tabBarCategory = newValue.userInfo["tab"] as? TabBarCategory else {
                    return
                }
                
                self?.selectedTab = tabBarCategory
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            guard tabCategory != .upload else {
                mainUseCase.showUpload()
                return
            }
            
            selectedTab = tabCategory
            mainUseCase.showPath(for: tabCategory)
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
        let previewSearchUseCase = PreviewSearchUseCase()
        let previewFavouritesUseCase = PreviewFavouritesUseCase()
        let previewUserProfileUseCase = PreviewUserProfileUseCase()
        
        return MainViewModel(
            mainUseCase: previewMainUseCase,
            homeUseCase: previewHomeUseCase,
            searchUseCase: previewSearchUseCase,
            favouritesUseCase: previewFavouritesUseCase,
            userProfileUseCase: previewUserProfileUseCase)
    }
}

#endif
