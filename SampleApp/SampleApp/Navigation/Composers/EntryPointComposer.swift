//
//  EntryPointComposer.swift
//  SampleApp
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import SearchFeature
import FavouritesFeature
import UserProfileFeature

class EntryPointComposer {
    let navigationController: UINavigationController
    let mainRouter: MainRouter
    
    init(navigationController: UINavigationController,
         mainRouter: MainRouter) {
        
        self.navigationController = navigationController
        self.mainRouter = mainRouter
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
