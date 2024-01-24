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
        if let routingController = navigationController.topViewController as? RoutingUIHostingController<AnyView>,
           !routingController.isRoot {
            switch routingController.tabCategory {
            case .home:
                if TabBarRoutes.shared.homeRoutingControllers.count > 0 {
                    TabBarRoutes.shared.homeRoutingControllers = TabBarRoutes.shared.homeRoutingControllers.dropLast()
                }
                
            case .search:
                if TabBarRoutes.shared.searchRoutingControllers.count > 0 {
                    TabBarRoutes.shared.searchRoutingControllers = TabBarRoutes.shared.searchRoutingControllers.dropLast()
                }
            case .notifications:
                if TabBarRoutes.shared.notificationsRoutingControllers.count > 0 {
                    TabBarRoutes.shared.notificationsRoutingControllers = TabBarRoutes.shared.notificationsRoutingControllers.dropLast()
                }
            case .profile:
                if TabBarRoutes.shared.profileRoutingControllers.count > 0 {
                    TabBarRoutes.shared.profileRoutingControllers = TabBarRoutes.shared.profileRoutingControllers.dropLast()
                }
            case .none:
                break
            }
            
            DispatchQueue.main.async {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    @MainActor
    public func dismissToRoot(for selectedTab: TabBarCategory) {
        
//        let mainRouter = MainRouter(navigationController: navigationController)
//        let mainSceneComposer = MainSceneComposer(
//            navigationController: navigationController,
//            mainRouter: mainRouter)
        
        switch selectedTab {
        case .home:
//            let homeViewController = mainSceneComposer.createViewController(for: .home)
            TabBarRoutes.shared.homeRoutingControllers = []
            removeViewControllers(for: .home)
//            self.navigationController.pushViewController(homeViewController, animated: true)
        case .search:
//            let searchViewController = mainSceneComposer.createViewController(for: .search)
            TabBarRoutes.shared.searchRoutingControllers = []
            removeViewControllers(for: .search)
//            self.navigationController.pushViewController(searchViewController, animated: true)
        case .notifications:
//            let notificationsViewController = mainSceneComposer.createViewController(for: .notifications)
            TabBarRoutes.shared.notificationsRoutingControllers = []
            removeViewControllers(for: .notifications)
//            self.navigationController.pushViewController(notificationsViewController, animated: true)
        case .profile:
//            let profileViewController = mainSceneComposer.createViewController(for: .profile)
            TabBarRoutes.shared.profileRoutingControllers = []
            removeViewControllers(for: .profile)
//            self.navigationController.pushViewController(profileViewController, animated: true)
        }
    }
    
    @MainActor
    public func showPath(for selectedTab: TabBarCategory) {
        switch selectedTab {
        case .home:
            print("### 1: \(self.navigationController.viewControllers.count)")
            let homeViewControllers = TabBarRoutes.shared.homeRoutingControllers
            self.navigationController.viewControllers.removeAll { uiViewController in
                guard let routingController = uiViewController as? RoutingUIHostingController<AnyView>,
                      routingController.isRoot else {
                    return true
                }
                
                return false
            }
            
            print("### 2: \(self.navigationController.viewControllers.count)")
            
            let viewControllers = homeViewControllers.reversed()
            var viewControllersCount = viewControllers.count
            
            for homeViewController in viewControllers {
                if viewControllersCount == homeViewControllers.count {
                    self.navigationController.pushViewController(homeViewController, animated: false)
                    viewControllersCount = viewControllersCount - 1
                    continue
                }
                
                if viewControllersCount == 0 {
                    break
                } else {
                    self.navigationController.viewControllers.insert(homeViewController, at: viewControllersCount)
                }
            }
        case .search:
            let searchViewControllers = TabBarRoutes.shared.searchRoutingControllers
            self.navigationController.viewControllers.removeAll { uiViewController in
                guard let routingController = uiViewController as? RoutingUIHostingController<AnyView>,
                      routingController.isRoot else {
                    return true
                }
                
                return false
            }
            
            if searchViewControllers.count > 1 {
                self.navigationController.viewControllers = searchViewControllers
            }
        case .notifications:
            let notificationsViewControllers = TabBarRoutes.shared.notificationsRoutingControllers
            self.navigationController.viewControllers.removeAll { uiViewController in
                guard let routingController = uiViewController as? RoutingUIHostingController<AnyView>,
                      routingController.isRoot else {
                    return true
                }
                
                return false
            }
            //            self.navigationController.viewControllers = notificationsViewControllers
            
            if notificationsViewControllers.count > 1 {
                self.navigationController.viewControllers = notificationsViewControllers
            }
        case .profile:
            print("### 4: \(self.navigationController.viewControllers.count)")
            let profileViewControllers = TabBarRoutes.shared.profileRoutingControllers
            self.navigationController.viewControllers.removeAll { uiViewController in
                guard let routingController = uiViewController as? RoutingUIHostingController<AnyView>,
                      routingController.isRoot else {
                    return true
                }
                
                return false
            }
            
            print("### 5: \(self.navigationController.viewControllers.count)")
            
            let viewControllers = profileViewControllers.reversed()
            var viewControllersCount = viewControllers.count
            
            for profileViewController in viewControllers {
                if viewControllersCount == profileViewControllers.count {
                    self.navigationController.pushViewController(profileViewController, animated: false)
                    viewControllersCount = viewControllersCount - 1
                    continue
                }
                
                if viewControllersCount == 0 {
                    break
                } else {
                    self.navigationController.viewControllers.insert(profileViewController, at: viewControllersCount)
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
