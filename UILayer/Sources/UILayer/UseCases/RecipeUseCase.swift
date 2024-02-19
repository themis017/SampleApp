//
//  RecipeUseCase.swift
//
//
//  Created by Themis Makedas on 6/2/24.
//

import Foundation
import Combine
import ApplicationLayer

public protocol RecipeUseCaseProviding {

    var selectedTab: Observable<TabBarCategory> { get }
    var recipe: Observable<Recipe?> { get }
    
    func dismiss(animated: Bool)
    func showUpload()
    func showPath(for selectedTab: TabBarCategory)
    func showChef()
    func favourite(_ recipe: Recipe)
}

public class RecipeUseCase: RecipeUseCaseProviding {
        
    public let selectedTab: Observable<TabBarCategory>
    public let recipe: Observable<Recipe?>
    
    private let homeRouter: any HomeRouting
    
    public init(selectedTab: TabBarCategory,
                recipe: Recipe,
                homeRouter: any HomeRouting) {
        
        self.homeRouter = homeRouter
        self.selectedTab = Observable(initialValue: selectedTab)
        self.recipe = Observable(initialValue: recipe)
    }
    
    public func dismiss(animated: Bool) {
        homeRouter.popScene(animated: animated)
    }
    
    public func showUpload() {
        homeRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        if self.selectedTab.value == selectedTab {
            homeRouter.dismissToRoot(for: selectedTab)
        } else {
            let selectedTabEvent = SelectedTabEvent()
            selectedTabEvent.userInfo["tab"] = selectedTab
            EventPipeline.shared.send(selectedTabEvent)
            
            homeRouter.showPath(for: selectedTab)
        }
    }
    
    public func showChef() {
        
    }
    
    public func favourite(_ updatedRecipe: Recipe) {
        
        guard var recipe = recipe.value else {
            return
        }
        
        recipe = recipe.chaningIsFavourite()
        self.recipe.value = recipe
        
        guard var favouriteRecipes: [Recipe] = AppData.shared.value(of: .favourites) else {
            return
        }
        
        if recipe.isFavourite {
            if favouriteRecipes.firstIndex(where: { $0.id == recipe.id }) == nil {
                favouriteRecipes.insert(recipe, at: 0)
            }
        } else {
            if let removedRecipeIndex = favouriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
                favouriteRecipes.remove(at: removedRecipeIndex)
            }
        }
        
        AppData.shared.save(favouriteRecipes, to: .favourites)
    }
}

#if DEBUG

public class PreviewRecipeUseCase: RecipeUseCaseProviding {
    
    public var selectedTab: Observable<TabBarCategory>
    public var recipe: Observable<Recipe?>
    
    public init() {
        self.selectedTab = .init(initialValue: .home)
        self.recipe = .init(initialValue: Recipe.previewHomeExamples.first)
    }
    
    public func dismiss(animated: Bool) {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
    public func showChef() {}
    public func favourite(_ recipe: Recipe) {}
}

#endif
