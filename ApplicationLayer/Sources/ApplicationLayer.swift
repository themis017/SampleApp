//
//  ApplicationLayer.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//

import EightUsersFoundation
import Resolver

public struct ApplicationCore: AppFeatureModule {
    public static let version: Version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("ApplicationCore") { container in

        }
    }
}
