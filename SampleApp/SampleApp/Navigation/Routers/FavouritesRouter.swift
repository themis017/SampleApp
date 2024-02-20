//
//  FavouritesRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import UIKit
import ApplicationLayer
import UILayer

class FavouritesRouter: BaseRouter, FavouritesRouting {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showRecipe(_ recipe: Recipe) {
        let homeRouter = HomeRouter(navigationController: navigationController)
        
        let useCase = RecipeUseCase(
            selectedTab: .favourites,
            recipe: recipe,
            homeRouter: homeRouter
        )
        
        let viewModel = RecipeViewModel(recipeUseCase: useCase)
        let view = RecipeView(viewModel: viewModel)
                
        let viewController = RoutingUIHostingController(
            sceneIdentity: RecipeView.sceneIdentity,
            isRoot: false,
            tabCategory: .home,
            view: AnyView(view))
        
        append(viewController, for: .home)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
