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
import SearchFeature
import FavouritesFeature
import UserProfileFeature

class MainSceneComposer {
    let navigationController: UINavigationController
    let mainRouter: MainRouter
    
    init(navigationController: UINavigationController, 
         mainRouter: MainRouter) {
        
        self.navigationController = navigationController
        self.mainRouter = mainRouter
    }
    
    @MainActor 
    func createMainScene(for selectedTab: TabBarCategory) -> RoutingUIHostingController<AnyView> {
        let mainUseCase = MainUseCase(selectedTab: selectedTab,
                                      mainRouter: mainRouter)
        
        let homeUseCase = HomeUseCase(
            homeRouter: HomeRouter(
                navigationController: navigationController)
        )
        
        let searchUseCase = SearchUseCase(
            searchRouter: SearchRouter(
                navigationController: navigationController)
        )
        
        let favouritesUseCase = FavouritesUseCase(
            favouritesRouter: FavouritesRouter(
                navigationController: navigationController)
        )
        
        let userProfileUseCase = UserProfileUseCase(
            userProfileRouter: UserProfileRouter(
                navigationController: navigationController)
        )
        
        let viewModel = MainViewModel(
            mainUseCase: mainUseCase,
            homeUseCase: homeUseCase,
            searchUseCase: searchUseCase,
            favouritesUseCase: favouritesUseCase,
            userProfileUseCase: userProfileUseCase)
        
        let view = AnyView(MainView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: MainView.sceneIdentity,
            isRoot: true,
            tabCategory: nil,
            view: view)
        
        return viewController
    }
    
    func pushScene(_ mainViewController: RoutingUIHostingController<AnyView>) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                let bottomPadding = window.safeAreaInsets.bottom
                let statusBar = UIView(frame: CGRect(
                    x: 0,
                    y: UIScreen.main.bounds.size.height - bottomPadding,
                    width: UIScreen.main.bounds.size.width,
                    height: bottomPadding)
                )
                
                statusBar.backgroundColor = .tabBarBackgroundColor
                window.addSubview(statusBar)
            }
        }
        
        self.navigationController.setToolbarHidden(false, animated: false)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(mainViewController, animated: true)
    }
}
