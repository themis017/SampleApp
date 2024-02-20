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
    func createEntryPointScene() -> RoutingUIHostingController<AnyView> {
        let useCase = EntryPointUseCase(mainRouter: mainRouter)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = AnyView(EntryPointView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: MainView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        
        return viewController
    }
}
