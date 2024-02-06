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
    
    @MainActor
    func showHomeDetails_A_Scene() {
        let homeRouter = HomeRouter(navigationController: navigationController)
        let useCase = HomeDetails_A_UseCase(homeRouter: homeRouter)
        let viewModel = HomeDetails_A_ViewModel(homeDetails_A_UseCase: useCase)
        let view = HomeDetails_A_View(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: HomeDetails_A_View.sceneIdentity,
            isRoot: false,
            tabCategory: .home,
            view: AnyView(view))
        
        append(viewController, for: .home)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showHomeDetails_B_Scene() {
        let homeRouter = HomeRouter(navigationController: navigationController)
        let useCase = HomeDetails_B_UseCase(homeRouter: homeRouter)
        let viewModel = HomeDetails_B_ViewModel(homeDetails_B_UseCase: useCase)
        let view = HomeDetails_B_View(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: HomeDetails_A_View.sceneIdentity,
            isRoot: false,
            tabCategory: .home,
            view: AnyView(view))
        
        append(viewController, for: .home)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

//class HomeRouter: BaseRouter, HomeRouting {
//        
//    override init(navigationController: UINavigationController) {
//        super.init(navigationController: navigationController)
//    }
//    
//    @MainActor
//    func showHomeDetails_A_Scene() {
//        let homeRouter = HomeRouter(navigationController: navigationController)
//        let useCase = HomeDetails_A_UseCase(homeRouter: homeRouter)
//        let viewModel = HomeDetails_A_ViewModel(homeDetails_A_UseCase: useCase)
//        let view = HomeDetails_A_View(viewModel: viewModel)
//        
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: HomeDetails_A_View.sceneIdentity,
//            isRoot: false,
//            tabCategory: .home,
//            view: AnyView(view))
//        
//        TabBarRoutes.shared.homeRoutingControllers.append(viewController)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    @MainActor
//    func showHomeDetails_B_Scene() {
//        let homeRouter = HomeRouter(navigationController: navigationController)
//        let useCase = HomeDetails_B_UseCase(homeRouter: homeRouter)
//        let viewModel = HomeDetails_B_ViewModel(homeDetails_B_UseCase: useCase)
//        let view = HomeDetails_B_View(viewModel: viewModel)
//        
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: HomeDetails_A_View.sceneIdentity,
//            isRoot: false,
//            tabCategory: .home,
//            view: AnyView(view))
//        
//        TabBarRoutes.shared.homeRoutingControllers.append(viewController)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//}
