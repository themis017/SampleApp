//
//  SignupRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import UIKit
import ApplicationLayer

class SignupRouter: BaseRouter, SignupRouting {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    @MainActor
    func showMainScene() {
        let mainRouter = MainRouter(navigationController: navigationController)
        let mainSceneComposer = MainSceneComposer(
            navigationController: navigationController,
            mainRouter: mainRouter)
        
        let mainViewController = mainSceneComposer.createMainScene(for: .home)
        mainSceneComposer.pushScene(mainViewController)
    }
}
