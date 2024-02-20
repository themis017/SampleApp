//
//  RecipeSceneComposer.swift
//  SampleApp
//
//  Created by Themis Makedas on 20/2/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer

class RecipeSceneComposer {
    let navigationController: UINavigationController
    let recipeRouter: RecipeRouter
    
    init(navigationController: UINavigationController,
         recipeRouter: RecipeRouter) {
        
        self.navigationController = navigationController
        self.recipeRouter = recipeRouter
    }
    
    @MainActor
    func createRecipeScene(for recipe: Recipe, from selectedTab: TabBarCategory) -> RoutingUIHostingController<AnyView> {
        
        let useCase = RecipeUseCase(selectedTab: selectedTab, 
                                    recipe: recipe,
                                    recipeRouter: recipeRouter)
        
        let viewModel = RecipeViewModel(recipeUseCase: useCase)
        let view = AnyView(RecipeView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: RecipeView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        
        return viewController
    }
}
