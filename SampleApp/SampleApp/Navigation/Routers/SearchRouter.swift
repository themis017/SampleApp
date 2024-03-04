//
//  SearchRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import UIKit
import ApplicationLayer

class SearchRouter: BaseRouter, SearchRouting {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showRecipe(_ recipe: Recipe) {
        let recipeRouter = RecipeRouter(navigationController: navigationController)
        let recipeSceneComposer = RecipeSceneComposer(
            navigationController: navigationController,
            recipeRouter: recipeRouter)
        
        let viewController = recipeSceneComposer.createRecipeScene(for: recipe, from: .search)
        append(viewController, for: .search)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showUser(_ user: UserReference) {
        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
        let profileSceneComposer = ProfileSceneComposer(
            navigationController: navigationController,
            userProfileRouter: userProfileRouter)
        
        let viewController = profileSceneComposer.createProfileScene(for: user, from: .search)
        append(viewController, for: .search)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
