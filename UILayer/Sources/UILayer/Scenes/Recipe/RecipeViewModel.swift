//
//  RecipeViewModel.swift
//
//
//  Created by Themis Makedas on 6/2/24.
//

import Foundation
import Combine
import ApplicationLayer

@MainActor
public class RecipeViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss(animated: Bool)
        case showChef
    }
    
    var selectedTab: TabBarCategory
    
    @Published
    var recipe: Recipe?
    
    private let recipeUseCase: RecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(recipeUseCase: RecipeUseCaseProviding) {
        
        self.recipeUseCase = recipeUseCase
        self.selectedTab = recipeUseCase.selectedTab.value
        self.recipe = recipeUseCase.recipe.value
        
        bind(\.recipe, to: recipeUseCase.recipe)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            guard tabCategory != .upload else {
                recipeUseCase.showUpload()
                return
            }
            
            recipeUseCase.showPath(for: tabCategory)
        case .dismiss(let animated):
            recipeUseCase.dismiss(animated: animated)
        case .showChef:
            recipeUseCase.showChef()
        }
    }
}

#if DEBUG

public extension RecipeViewModel {
    
    static func previewViewModel() -> RecipeViewModel {
        let previewUseCase = PreviewRecipeUseCase()
        return RecipeViewModel(recipeUseCase: previewUseCase)
    }
}

#endif
