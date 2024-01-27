//
//  MainRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import UserProfileFeature
import SettingsFeature

class MainRouter: BaseRouter, MainRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showLandingScene() {
        let useCase = LandingUseCase(mainRouter: self)
        let viewModel = LandingViewModel(landingUseCase: useCase)
        let view = LandingView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showEntryPointScene() {
        let useCase = EntryPointUseCase(mainRouter: self)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = EntryPointView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showMainScene() {
        let mainSceneComposer = MainSceneComposer(
            navigationController: navigationController,
            mainRouter: self)
        
        let mainViewController = mainSceneComposer.createMainScene(for: .home)
        
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(mainViewController, animated: true)
    }
}
