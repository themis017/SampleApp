//
//  AppFeatureModule.swift
//  
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation

public protocol AppFeatureModule {
    
    /// The feature implemented in this module
    var feature: AppFeature { get }
    
    /// Notifies the feature module that the application will launch.
    func willLaunchApplication()
    
    /// Allows each feature module to register system level services.
    /// - Note: This functin will be invoked **after** the application has launched and all features have been composed, but **before** didLaunch is called.
    func registerSystemServices(into systemServiceExecutor: any SystemServiceExecutor)
    
    /// Notifies the feature module that the application has launched and all features have been composed.
    /// - Parameter application: The launched application.
    func didLaunch(application: Application)
}

public extension AppFeatureModule {
    
    func willLaunchApplication() {}
    
    func registerSystemServices(into systemServiceExecutor: any SystemServiceExecutor) {}
    
    func didLaunch(application: Application) {}
}
