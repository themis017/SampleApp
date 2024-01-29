//
//  UserProfileRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UserProfileFeature

class UserProfileRouter: BaseRouter, UserProfileRouting {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showEntryPointScene() {
        let mainRouter = MainRouter(navigationController: navigationController)
        let entryPointSceneComposer = EntryPointComposer(
            navigationController: navigationController,
            mainRouter: mainRouter)
        
        let entryPointViewController = entryPointSceneComposer.createEntryPointScene()
        
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(entryPointViewController, animated: true)
    }
    
    
    @MainActor
    func showUserProfile_A_Scene() {
        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
        let useCase = UserProfile_A_UseCase(userProfileRouter: userProfileRouter)
        let viewModel = UserProfile_A_ViewModel(userProfile_A_UseCase: useCase)
        let view = UserProfile_A_View(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: UserProfile_A_View.sceneIdentity,
            isRoot: false,
            tabCategory: .profile,
            view: AnyView(view))
        
        append(viewController, for: .profile)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    @MainActor
    func showUserProfile_B_Scene() {
        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
        let useCase = UserProfile_B_UseCase(userProfileRouter: userProfileRouter)
        let viewModel = UserProfile_B_ViewModel(userProfile_B_UseCase: useCase)
        let view = UserProfile_B_View(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: UserProfile_B_View.sceneIdentity,
            isRoot: false,
            tabCategory: .profile,
            view: AnyView(view))
        
        append(viewController, for: .profile)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

//class UserProfileRouter: BaseRouter, UserProfileRouting {
//    
//    override init(navigationController: UINavigationController) {
//        super.init(navigationController: navigationController)
//    }
//    
//    @MainActor
//    func showUserProfile_A_Scene() {
//        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
//        let useCase = UserProfile_A_UseCase(userProfileRouter: userProfileRouter)
//        let viewModel = UserProfile_A_ViewModel(userProfile_A_UseCase: useCase)
//        let view = UserProfile_A_View(viewModel: viewModel)
//        
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: UserProfile_A_View.sceneIdentity,
//            isRoot: false,
//            tabCategory: .profile,
//            view: AnyView(view))
//        
//        TabBarRoutes.shared.profileRoutingControllers.append(viewController)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    @MainActor
//    func showUserProfile_B_Scene() {
//        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
//        let useCase = UserProfile_B_UseCase(userProfileRouter: userProfileRouter)
//        let viewModel = UserProfile_B_ViewModel(userProfile_B_UseCase: useCase)
//        let view = UserProfile_B_View(viewModel: viewModel)
//        
//        let viewController = RoutingUIHostingController(
//            sceneIdentity: UserProfile_B_View.sceneIdentity,
//            isRoot: false,
//            tabCategory: .profile,
//            view: AnyView(view))
//        
//        TabBarRoutes.shared.profileRoutingControllers.append(viewController)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//}
