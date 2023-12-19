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

class UserProfileRouter: BaseRouter, UserProfileRouting {
    
    @MainActor
    func showSettings() {
        let presentation = PushPresentation()
        let baseRouter = BaseRouter(rootPresentation: presentation)
        
        let useCase = FirstSettingsUseCase()
        let viewModel = FirstSettingsViewModel(firstSettingsUseCase: useCase)
        let view = FirstSettingsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        baseRouter.root = viewController
        
        route(to: navigationController, as: presentation)
    }
}
