//
//  SceneDelegate.swift
//  SampleApp
//
//  Created by Themis Makedas on 14/11/23.
//

import UIKit
import SwiftUI
import HomeFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let windowScene = scene as? UIWindowScene {
            
            
            let navigationController = CustomNavigationController(rootViewController: UIHostingController(rootView: ContentView()))
            
            navigationController.overrideUserInterfaceStyle = .light
//            navigationController.isNavigationBarHidden = false
            navigationController.setToolbarHidden(false, animated: false)
            
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithDefaultBackground()
//            appearance.backgroundColor = UIColor.red
//
//            navigationController.navigationBar.standardAppearance = appearance
//            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
            
//            navigationController.navigationBar.backItem?.title = ""
//            navigationController.navigationBar.backIndicatorImage = UIImage()
//            navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage() 
            navigationController.toolbar.isTranslucent = false
//            navigationController.toolbar.barTintColor = UIColor.tabBarBackgroundColor
            navigationController.toolbar.backgroundColor = .red
            
//            // Adjust toolbar frame to cover the entire safe area
//            if let rootView = window?.rootViewController?.view {
//                let safeAreaBottomInset = rootView.safeAreaInsets.bottom
//                navigationController.toolbar.frame = CGRect(x: 0, y: rootView.bounds.height - navigationController.toolbar.frame.height - safeAreaBottomInset, width: rootView.bounds.width, height: navigationController.toolbar.frame.height + safeAreaBottomInset)
//            }
            
//            let temp = UIToolbarAppearance()
//            temp.backgroundColor = .red
//            
//            navigationController.toolbar.standardAppearance = temp
//            navigationController.toolbar.compactAppearance = temp
            
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
//            // Adjust toolbar frame to cover the entire safe area
//                    if let window = window {
//                        let safeAreaInsets = window.safeAreaInsets
//                        let toolbarHeight = navigationController.toolbar.frame.height
//                        navigationController.toolbar.frame = CGRect(x: 0, y: window.bounds.height - toolbarHeight - safeAreaInsets.bottom, width: window.bounds.width, height: toolbarHeight + safeAreaInsets.bottom)
//                    }
            
            let mainRouter = MainRouter(navigationController: navigationController)
            mainRouter.showLandingScene()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

class CustomNavigationController: UINavigationController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Adjust toolbar frame to cover the entire safe area
        if let toolbar = toolbar {
            let safeAreaInsets = view.safeAreaInsets
            let toolbarHeight = toolbar.frame.height
            toolbar.frame = CGRect(x: 0, y: view.bounds.height - toolbarHeight - safeAreaInsets.bottom, width: view.bounds.width, height: toolbarHeight + safeAreaInsets.bottom)
        }
    }
}
