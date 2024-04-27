//
//  EntryPointSceneComposer.swift
//  SampleApp
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature

class EntryPointSceneComposer {
    let navigationController: UINavigationController
    let mainRouter: MainRouter
    
    init(navigationController: UINavigationController,
         mainRouter: MainRouter) {
        
        self.navigationController = navigationController
        self.mainRouter = mainRouter
    }
    
    @MainActor
    func createEntryPointScene() -> RoutingUIHostingController<AnyView> {
        let useCase = EntryPointUseCase(mainRouter: mainRouter)
        let viewModel = EntryPointViewModel(entryPointUseCase: useCase)
        let view = AnyView(EntryPointView(viewModel: viewModel))
        let viewController = RoutingUIHostingController(
            sceneIdentity: EntryPointView.sceneIdentity,
            isRoot: false,
            tabCategory: nil,
            view: view)
        
        return viewController
    }
    
    func pushScene(_ entryPointViewController: RoutingUIHostingController<AnyView>) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                let bottomPadding = window.safeAreaInsets.bottom
                let statusBar = UIView(frame: CGRect(
                    x: 0,
                    y: UIScreen.main.bounds.size.height - bottomPadding,
                    width: UIScreen.main.bounds.size.width,
                    height: bottomPadding)
                )
                
                statusBar.backgroundColor = .clear
                window.addSubview(statusBar)
            }
        }
        
        self.navigationController.setToolbarHidden(true, animated: false)
        self.navigationController.viewControllers.removeAll()
        self.navigationController.pushViewController(entryPointViewController, animated: true)
    }
}
