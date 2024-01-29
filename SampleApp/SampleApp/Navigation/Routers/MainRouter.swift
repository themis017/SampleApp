//
//  MainRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import SignupFeature
import LoginFeature
import MainFeature
import HomeFeature
import UserProfileFeature

class MainRouter: BaseRouter, MainRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showLandingScene() {
        let useCase = LandingUseCase(mainRouter: self)
        let viewModel = LandingViewModel(landingUseCase: useCase)
        let view = AnyView(LandingView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: LandingView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showEntryPointScene() {
        let entryPointSceneComposer = EntryPointComposer(
            navigationController: navigationController,
            mainRouter: self)
        
        let entryPointViewController = entryPointSceneComposer.createEntryPointScene()
        
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(entryPointViewController, animated: true)
    }
    
    @MainActor
    func showSignupScene() {
        let signupRouter = SignupRouter(navigationController: navigationController)
        let useCase = SignupUseCase(signupRouter: signupRouter)
        let viewModel = SignupViewModel(signupUseCase: useCase)
        let view = AnyView(SignupView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: SignupView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showLoginScene() {
        let loginRouter = LoginRouter(navigationController: navigationController)
        let useCase = LoginUseCase(loginRouter: loginRouter)
        let viewModel = LoginViewModel(loginUseCase: useCase)
        let view = AnyView(LoginView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: LoginView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        
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
