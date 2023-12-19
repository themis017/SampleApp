//
//  HomeRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UserProfileFeature

class HomeRouter: BaseRouter, HomeRouting {
    
    @MainActor
    func showProfile() {
        let presentation = PushPresentation()
        let baseRouter = BaseRouter(rootPresentation: presentation)
        
        let useCase = UserProfileUseCase()
        let viewModel = UserProfileViewModel(userProfileUseCase: useCase)
        let view = UserProfileView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        baseRouter.root = viewController
        
        route(to: navigationController, as: presentation)
    }
}
