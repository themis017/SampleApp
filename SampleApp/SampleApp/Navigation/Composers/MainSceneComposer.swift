//
//  MainSceneComposer.swift
//  SampleApp
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import UserProfileFeature
import SettingsFeature

class MainSceneComposer {
    let navigationController: UINavigationController
    let mainRouter: MainRouter
    
    init(navigationController: UINavigationController, 
         mainRouter: MainRouter) {
        
        self.navigationController = navigationController
        self.mainRouter = mainRouter
    }
    
    @MainActor 
    func createViewController(for selectedTab: TabBarCategory) -> RoutingUIHostingController<AnyView> {
        let mainUseCase = MainUseCase(selectedTab: selectedTab,
                                      mainRouter: mainRouter)
        
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
        
        let view = AnyView(MainView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: MainView.sceneIdentity,
            isRoot: true,
            tabCategory: selectedTab,
            view: view)
        
        return viewController
    }
}
