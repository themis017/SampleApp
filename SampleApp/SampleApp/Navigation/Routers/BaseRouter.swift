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
        if let routingController = navigationController.topViewController as? RoutingUIHostingController<AnyView> {
            switch routingController.tabCategory {
            case .home:
                TabBarRoutes.shared.homeRoutingControllers = TabBarRoutes.shared.homeRoutingControllers.dropLast()
            case .search:
                TabBarRoutes.shared.searchRoutingControllers = TabBarRoutes.shared.searchRoutingControllers.dropLast()
            case .notifications:
                TabBarRoutes.shared.notificationsRoutingControllers = TabBarRoutes.shared.notificationsRoutingControllers.dropLast()
            case .profile:
                TabBarRoutes.shared.profileRoutingControllers = TabBarRoutes.shared.profileRoutingControllers.dropLast()
            }
        }
        
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    @MainActor
    public func dismissToRoot(for selectedTab: TabBarCategory) {
        
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
    
    @MainActor
    public func showPath(for selectedTab: TabBarCategory) {
        switch selectedTab {
        case .home:
            let homeViewControllers = TabBarRoutes.shared.homeRoutingControllers
            self.navigationController.viewControllers.removeAll()
//            self.navigationController.viewControllers = homeViewControllers
            
            if homeViewControllers.count > 1 {
                self.navigationController.viewControllers = homeViewControllers
            } else {
                if let firstHomeViewController = homeViewControllers.first {
                    self.navigationController.pushViewController(firstHomeViewController, animated: true)
                }
            }
        case .search:
            let searchViewControllers = TabBarRoutes.shared.searchRoutingControllers
            self.navigationController.viewControllers.removeAll()
//            self.navigationController.viewControllers = searchViewControllers
            
            if searchViewControllers.count > 1 {
                self.navigationController.viewControllers = searchViewControllers
            } else {
                if let firstSearchViewController = searchViewControllers.first {
                    self.navigationController.pushViewController(firstSearchViewController, animated: true)
                }
            }
        case .notifications:
            let notificationsViewControllers = TabBarRoutes.shared.notificationsRoutingControllers
            self.navigationController.viewControllers.removeAll()
//            self.navigationController.viewControllers = notificationsViewControllers
            
            if notificationsViewControllers.count > 1 {
                self.navigationController.viewControllers = notificationsViewControllers
            } else {
                if let firstNotificationsViewController = notificationsViewControllers.first {
                    self.navigationController.pushViewController(firstNotificationsViewController, animated: true)
                }
            }
        case .profile:
            let profileViewControllers = TabBarRoutes.shared.profileRoutingControllers
            self.navigationController.viewControllers.removeAll()
//            self.navigationController.viewControllers = profileViewControllers
            
            if profileViewControllers.count > 1 {
                self.navigationController.viewControllers = profileViewControllers
            } else {
                if let firstProfileViewController = profileViewControllers.first {
                    self.navigationController.pushViewController(firstProfileViewController, animated: true)
                }
            }
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
