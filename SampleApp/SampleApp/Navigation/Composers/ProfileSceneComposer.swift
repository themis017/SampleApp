//
//  ProfileSceneComposer.swift
//  SampleApp
//
//  Created by Themis Makedas on 4/3/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer
import UserProfileFeature

class ProfileSceneComposer {
    let navigationController: UINavigationController
    let userProfileRouter: UserProfileRouter
    
    init(navigationController: UINavigationController,
         userProfileRouter: UserProfileRouter) {
        
        self.navigationController = navigationController
        self.userProfileRouter = userProfileRouter
    }
    
    @MainActor
    func createProfileScene(for user: UserReference, from selectedTab: TabBarCategory) -> RoutingUIHostingController<AnyView> {
        
        let useCase = OtherUserProfileUseCase(
            selectedTab: selectedTab,
            user: user,
            userProfileRouter: userProfileRouter)
        
        let viewModel = OtherUserProfileViewModel(otherUserProfileUseCase: useCase)
        let view = AnyView(OtherUserProfileView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: OtherUserProfileView.sceneIdentity,
            isRoot: false,
            tabCategory: selectedTab,
            view: view)
        
        return viewController
    }
}
