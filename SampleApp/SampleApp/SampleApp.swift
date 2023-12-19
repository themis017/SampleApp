//
//  SampleApp.swift
//  SampleApp
//
//  Created by Themis Makedas on 21/11/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import NetworkLayer
import UILayer
import HomeFeature
import UserProfileFeature
import SettingsFeature

@main
struct SampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    private let appRootRouter: AppRootRouting
    
    let application = Application(
        featureModules: [
            
            iOSApplication(),
            
            // Infrastructure
            ApplicationLayer(),
            NetworkLayer(),
            UILayer(),
            
            // Features
            HomeFeature(),
            UserProfileFeature(),
            SettingsFeature()
        ]
    )
    
    init() {
        // MARK:  Launch Application and Feature Modules
        application.launch()
        
        // MARK: UIViewAppearance Modifications
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .blue
        
        // MARK: App initial routing
        let presentation = PushPresentation()
        let appRootRouter = AppRootRouter(rootPresentation: presentation)
        self.appRootRouter = appRootRouter
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(appRootRouter: appRootRouter)
                .preferredColorScheme(.light)
        }
    }
}
