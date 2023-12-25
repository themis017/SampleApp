////
////  SampleApp.swift
////  SampleApp
////
////  Created by Themis Makedas on 21/11/23.
////
//
//import Foundation
//import SwiftUI
//import ApplicationLayer
//import NetworkLayer
//import UILayer
//import HomeFeature
//import UserProfileFeature
//import SettingsFeature
//
//@main
//struct SampleApp: App {
//    
//    @UIApplicationDelegateAdaptor(AppDelegate.self)
//    private var appDelegate
//    
//    let application = Application(
//        featureModules: [
//            
//            iOSApplication(),
//            
//            // Infrastructure
//            ApplicationLayer(),
//            NetworkLayer(),
//            UILayer(),
//            
//            // Features
//            HomeFeature(),
//            UserProfileFeature(),
//            SettingsFeature()
//        ]
//    )
//    
//    init() {
//        // MARK:  Launch Application and Feature Modules
//        application.launch()
//        
//        // MARK: UIViewAppearance Modifications
//        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .blue
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .preferredColorScheme(.light)
//        }
//    }
//}
