//
//  AppRootRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import Resolver
import ApplicationLayer
import HomeFeature

class AppRootRouter: BaseRouter, AppRootRouting {
    
    @MainActor
    func showEntryPoint() {
        let presentation = PushPresentation()
        let baseRouter = BaseRouter(rootPresentation: presentation)
        
        let appRootRouter = AppRootRouter(rootPresentation: presentation)
        let view = EntryPointView(appRootRouter: appRootRouter)
        let viewController = UIHostingController(rootView: view)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        baseRouter.root = viewController
        
        route(to: viewController, as: presentation)
    }
    
    @MainActor
    func showHome() {
        let presentation = PushPresentation()
        let baseRouter = BaseRouter(rootPresentation: presentation)
        
        let useCase = HomeUseCase()
        let viewModel = HomeViewModel(homeUseCase: useCase)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
//        let navigationController = UINavigationController(rootViewController: viewController)
        root = viewController
        
        route(to: viewController, as: presentation)
    }
}
