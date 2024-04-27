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
        let entryPointSceneComposer = EntryPointSceneComposer(
            navigationController: navigationController,
            mainRouter: mainRouter)
        
        let entryPointViewController = entryPointSceneComposer.createEntryPointScene()
        entryPointSceneComposer.pushScene(entryPointViewController)
    }
    
    @MainActor
    func showEditProfileScene() {
        let userProfileRouter = UserProfileRouter(navigationController: navigationController)
        let useCase = EditProfileUseCase(userProfileRouter: userProfileRouter)
        let viewModel = EditProfileViewModel(editProfileUseCase: useCase)
        let view = EditProfileView(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: EditProfileView.sceneIdentity,
            isRoot: false,
            tabCategory: .profile,
            view: AnyView(view))
        
        append(viewController, for: .profile)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
