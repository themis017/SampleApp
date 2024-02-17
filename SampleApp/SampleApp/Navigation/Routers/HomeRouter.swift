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
        let homeRouter = HomeRouter(navigationController: navigationController)
        
        let useCase = RecipeUseCase(
            selectedTab: .home,
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
