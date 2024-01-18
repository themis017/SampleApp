//
//  BaseRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 26/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import UserProfileFeature
import SettingsFeature

open class BaseRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor
    public func popScene() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    @MainActor
    func dismissToRoot(for selectedTab: TabBarCategory) {
        
        let mainRouter = MainRouter(navigationController: navigationController)
        let mainSceneComposer = MainSceneComposer(
            navigationController: navigationController,
            mainRouter: mainRouter)
        
        switch selectedTab {
        case .home:
            let homeViewController = mainSceneComposer.createViewController(for: .home)
            TabBarRoutes.shared.homeRoutingControllers = [homeViewController]
            removeViewControllers(for: .home)
            self.navigationController.pushViewController(homeViewController, animated: true)
        case .search:
            let searchViewController = mainSceneComposer.createViewController(for: .search)
            TabBarRoutes.shared.searchRoutingControllers = [searchViewController]
            removeViewControllers(for: .search)
            self.navigationController.pushViewController(searchViewController, animated: true)
        case .notifications:
            let notificationsViewController = mainSceneComposer.createViewController(for: .notifications)
            TabBarRoutes.shared.notificationsRoutingControllers = [notificationsViewController]
            removeViewControllers(for: .notifications)
            self.navigationController.pushViewController(notificationsViewController, animated: true)
        case .profile:
            let profileViewController = mainSceneComposer.createViewController(for: .profile)
            TabBarRoutes.shared.profileRoutingControllers = [profileViewController]
            removeViewControllers(for: .profile)
            self.navigationController.pushViewController(profileViewController, animated: true)
        }
    }
    
    private func removeViewControllers(for selectedTab: TabBarCategory) {
        self.navigationController.viewControllers.removeAll { viewController in
            guard let routingController = viewController as? RoutingUIHostingController<AnyView>,
                  routingController.tabCategory == selectedTab  else {
                return false
            }
            
            return true
        }
    }
}
