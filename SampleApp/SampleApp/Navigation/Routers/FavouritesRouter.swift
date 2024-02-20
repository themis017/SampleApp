//
//  FavouritesRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import UIKit
import SwiftUI
import ApplicationLayer
import UILayer

class FavouritesRouter: BaseRouter, FavouritesRouting {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showRecipe(_ recipe: Recipe) {
        
        let recipeRouter = RecipeRouter(navigationController: navigationController)
        let recipeSceneComposer = RecipeSceneComposer(
            navigationController: navigationController,
            recipeRouter: recipeRouter)
        
        let viewController = recipeSceneComposer.createRecipeScene(for: recipe, from: .favourites)
        append(viewController, for: .favourites)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
