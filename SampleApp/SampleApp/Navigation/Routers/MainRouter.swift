//
//  MainRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import UserProfileFeature
import SettingsFeature

class MainRouter: BaseRouter, MainRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showEntryPointScene() {
        let useCase = EntryPointUseCase(mainRouter: self)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = EntryPointView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showMainScene() {
        
        let mainSceneComposer = MainSceneComposer(
            navigationController: navigationController,
            mainRouter: self)
        
        let homeViewController = mainSceneComposer.createMainScene(for: .home)
//        let searchViewController = mainSceneComposer.createViewController(for: .search)
//        let notificationsViewController = mainSceneComposer.createViewController(for: .notifications)
//        let profileViewController = mainSceneComposer.createViewController(for: .profile)
        
//        TabBarRoutes.shared.homeRoutingControllers = [homeViewController]
//        TabBarRoutes.shared.searchRoutingControllers = [searchViewController]
//        TabBarRoutes.shared.notificationsRoutingControllers = [notificationsViewController]
//        TabBarRoutes.shared.profileRoutingControllers = [profileViewController]
        
//        TabBarRoutes.shared.homeRoutingControllers = [homeViewController]
//        TabBarRoutes.shared.searchRoutingControllers = [homeViewController]
//        TabBarRoutes.shared.notificationsRoutingControllers = [homeViewController]
//        TabBarRoutes.shared.profileRoutingControllers = [homeViewController]
        
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
//    @MainActor
//    func dismissToRoot(for selectedTab: TabBarCategory) {
//        
//        let mainSceneComposer = MainSceneComposer(
//            navigationController: navigationController,
//            mainRouter: self)
//        
//        switch selectedTab {
//        case .home:
//            let homeViewController = mainSceneComposer.createViewController(for: .home)
//            TabBarRoutes.shared.homeRoutingControllers = [homeViewController]
//            removeViewControllers(for: .home)
//            self.navigationController.pushViewController(homeViewController, animated: true)
//        case .search:
//            let searchViewController = mainSceneComposer.createViewController(for: .search)
//            TabBarRoutes.shared.searchRoutingControllers = [searchViewController]
//            removeViewControllers(for: .search)
//            self.navigationController.pushViewController(searchViewController, animated: true)
//        case .notifications:
//            let notificationsViewController = mainSceneComposer.createViewController(for: .notifications)
//            TabBarRoutes.shared.notificationsRoutingControllers = [notificationsViewController]
//            removeViewControllers(for: .notifications)
//            self.navigationController.pushViewController(notificationsViewController, animated: true)
//        case .profile:
//            let profileViewController = mainSceneComposer.createViewController(for: .profile)
//            TabBarRoutes.shared.profileRoutingControllers = [profileViewController]
//            removeViewControllers(for: .profile)
//            self.navigationController.pushViewController(profileViewController, animated: true)
//        }
//    }
    
//    private func removeViewControllers(for selectedTab: TabBarCategory) {
//        self.navigationController.viewControllers.removeAll { viewController in
//            guard let routingController = viewController as? RoutingUIHostingController<AnyView>,
//                  routingController.tabCategory == selectedTab  else {
//                return false
//            }
//            
//            return true
//        }
//    }
    
//    @MainActor
//    func showHomeScene() {
//        let router = HomeRouter(navigationController: navigationController)
//        let useCase = HomeUseCase(homeRouter: router)
//        let viewModel = HomeViewModel(homeUseCase: useCase)
//        let view = HomeView(viewModel: viewModel)
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: HomeView.sceneIdentity,
//            isRoot: true,
//            tabCategory: .home,
//            view: view)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    @MainActor
//    func showUserProfileScene() {
//        let router = UserProfileRouter(navigationController: navigationController)
//        let useCase = UserProfileUseCase(userProfileRouter: router)
//        let viewModel = UserProfileViewModel(userProfileUseCase: useCase)
//        let view = UserProfileView(viewModel: viewModel)
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: UserProfileView.sceneIdentity,
//            isRoot: true,
//            tabCategory: .profile,
//            view: view)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    @MainActor
//    func showSettingsScene() {
//        let router = SettingsRouter(navigationController: navigationController)
//        let useCase = SettingsUseCase(settingsRouter: router)
//        let viewModel = SettingsViewModel(settingsUseCase: useCase)
//        let view = SettingsView(viewModel: viewModel)
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: SettingsView.sceneIdentity,
//            isRoot: true,
//            tabCategory: .home,
//            view: view)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
}
