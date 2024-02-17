//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Themis Makedas on 14/11/23.
//

//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}

import UIKit
import ApplicationLayer
import NetworkLayer
import UILayer
import MainFeature
import SignupFeature
import LoginFeature
import HomeFeature
import SearchFeature
import FavouritesFeature
import UserProfileFeature

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let application = Application(
        featureModules: [
            
            iOSApplication(),
            
            // Infrastructure
            ApplicationLayer(),
            NetworkLayer(),
            UILayer(),
            
            // Features
            MainFeature(),
            SignupFeature(),
            LoginFeature(),
            HomeFeature(),
            SearchFeature(),
            FavouritesFeature(),
            UserProfileFeature()
        ]
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK:  Launch Application and Feature Modules
        self.application.launch()
        
        // MARK: UIViewAppearance Modifications
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .blue
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
                
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

