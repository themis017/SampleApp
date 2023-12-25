//
//  HomeRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import HomeFeature
import UserProfileFeature

class HomeRouter: BaseRouter, HomeRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showEntryPointScene() {
        let useCase = EntryPointUseCase(homeRouter: self)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = EntryPointView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showHomeScene() {
        let useCase = HomeUseCase(homeRouter: self)
        let viewModel = HomeViewModel(homeUseCase: useCase)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showUserProfileScene() {
        let router = UserProfileRouter(navigationController: navigationController)
        let useCase = UserProfileUseCase(userProfileRouter: router)
        let viewModel = UserProfileViewModel(userProfileUseCase: useCase)
        let view = UserProfileView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
