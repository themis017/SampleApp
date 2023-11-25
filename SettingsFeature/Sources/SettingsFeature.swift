//
//  SettingsFeature.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//

import Resolver

public struct NetworkLayer: AppFeatureModule {
    public static let version: Version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("SettingsFeature") { container in

        }
    }
}
