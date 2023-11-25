//
//  AppFeatureModule.swift
//  
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation

public protocol AppFeatureModule {
    
    var feature: AppFeature { get }
    
    func willLaunchApplication()
    func didLaunch(application: Application)
}

public extension AppFeatureModule {
    
    func willLaunchApplication() {}
    
    func didLaunch(application: Application) {}
}
