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
    func showEntryPointScene() {
        let useCase = EntryPointUseCase(mainRouter: self)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = EntryPointView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = EntryPointView.sceneIdentity
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showMainScene() {
        let mainUseCase = MainUseCase(mainRouter: self)
        
        let homeUseCase = HomeUseCase(
            homeRouter: HomeRouter(
                navigationController: navigationController)
        )
        
        let userProfileUseCase = UserProfileUseCase(
            userProfileRouter: UserProfileRouter(
                navigationController: navigationController)
        )
        
        let settingsUseCase = SettingsUseCase(
            settingsRouter: SettingsRouter(
                navigationController: navigationController)
        )
        
        let viewModel = MainViewModel(
            mainUseCase: mainUseCase,
            homeUseCase: homeUseCase,
            userProfileUseCase: userProfileUseCase,
            settingsUseCase: settingsUseCase)
        
        let view = MainView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = MainView.sceneIdentity
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showHomeScene() {
        let router = HomeRouter(navigationController: navigationController)
        let useCase = HomeUseCase(homeRouter: router)
        let viewModel = HomeViewModel(homeUseCase: useCase)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = HomeView.sceneIdentity
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showUserProfileScene() {
        let router = UserProfileRouter(navigationController: navigationController)
        let useCase = UserProfileUseCase(userProfileRouter: router)
        let viewModel = UserProfileViewModel(userProfileUseCase: useCase)
        let view = UserProfileView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = UserProfileView.sceneIdentity
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showSettingsScene() {
        let router = SettingsRouter(navigationController: navigationController)
        let useCase = SettingsUseCase(settingsRouter: router)
        let viewModel = SettingsViewModel(settingsUseCase: useCase)
        let view = SettingsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = SettingsView.sceneIdentity
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
