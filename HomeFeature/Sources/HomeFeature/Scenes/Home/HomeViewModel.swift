//
//  HomeViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class HomeViewModel: ViewModel {
    
    public enum Action {
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory = .home
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    private let homeUseCase: HomeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(homeUseCase: HomeUseCaseProviding) {
        self.randomProperty = homeUseCase.randomProperty.value
        self.homeUseCase = homeUseCase
        
        bind(\.randomProperty, to: homeUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: homeUseCase.randomText)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            homeUseCase.nextAction()
        }
    }
}

#if DEBUG

public extension HomeViewModel {
    
    static func previewViewModel() -> HomeViewModel {
        let previewUseCase = PreviewHomeUseCase()
        return HomeViewModel(homeUseCase: previewUseCase)
    }
}

#endif
