//
//  HomeRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer
import MainFeature
import HomeFeature

class HomeRouter: BaseRouter, HomeRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showRecipe(_ recipe: Recipe) {
        let recipeRouter = RecipeRouter(navigationController: navigationController)
        let recipeSceneComposer = RecipeSceneComposer(
            navigationController: navigationController,
            recipeRouter: recipeRouter)
        
        let viewController = recipeSceneComposer.createRecipeScene(for: recipe, from: .home)
        append(viewController, for: .home)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
