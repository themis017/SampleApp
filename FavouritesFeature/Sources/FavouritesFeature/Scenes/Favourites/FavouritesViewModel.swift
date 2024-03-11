//
//  FavouritesViewModel.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class FavouritesViewModel: ViewModel {
    
    public enum Action {
        case showRecipe(Recipe)
        case removeRecipe(Recipe)
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var recipes: [Recipe]?
    
    private let favouritesUseCase: FavouritesUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(favouritesUseCase: FavouritesUseCaseProviding) {
        self.favouritesUseCase = favouritesUseCase
        
        self.userProfile = favouritesUseCase.userProfile.value
        self.recipes = favouritesUseCase.recipes.value
        
        bind(\.userProfile, to: favouritesUseCase.userProfile)
            .store(in: &subscriptions)
        
        bind(\.recipes, to: favouritesUseCase.recipes)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showRecipe(let recipe):
            favouritesUseCase.showRecipe(recipe)
        case .removeRecipe(let recipe):
            favouritesUseCase.removeRecipe(recipe)
        }
    }
}

#if DEBUG

public extension FavouritesViewModel {
    
    static func previewViewModel() -> FavouritesViewModel {
        let previewUseCase = PreviewFavouritesUseCase()
        return FavouritesViewModel(favouritesUseCase: previewUseCase)
    }
}

#endif
