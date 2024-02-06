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
        case refresh
        case showRecipe(Recipe)
    }
    
    @Published
    var recipes: [Recipe]
    
    private let homeUseCase: HomeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(homeUseCase: HomeUseCaseProviding) {
        self.homeUseCase = homeUseCase
        
        self.recipes = homeUseCase.recipes.value
        
        bind(\.recipes, to: homeUseCase.recipes)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .refresh:
            homeUseCase.refresh()
        case .showRecipe(let recipe):
            homeUseCase.showRecipe(recipe)
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
