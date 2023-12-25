//
//  UserProfileRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import SettingsFeature

class UserProfileRouter: UserProfileRouting {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor
    func showSettings() {
        let router = SettingsRouter(navigationController: navigationController)
        let useCase = SettingsUseCase(settingsRouter: router)
        let viewModel = SettingsViewModel(settingsUseCase: useCase)
        let view = SettingsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
