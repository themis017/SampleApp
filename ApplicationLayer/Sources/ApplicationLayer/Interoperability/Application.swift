//
//  Application.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation
import Resolver

public class Application {
    
    private let featureModules: [AppFeatureModule]
    
    public init(featureModules: [AppFeatureModule]) {
        self.featureModules = featureModules
    }
    
    public func launch() {
        print("Launching...")
        
        featureModules.forEach { featureModule in
            featureModule.willLaunchApplication()
            print("Launching module \(featureModule.feature.name)...")
        }
        
        defer {
            print("Launched iOS Application.")
            
            DispatchQueue.main.async {
                self.featureModules.forEach({ $0.didLaunch(application: self) })
            }
        }
        
        let resolverContainer = Resolver.main
        let features = featureModules.map({ $0.feature })
        features.forEach({ $0.initialize(using: resolverContainer) })
    }
}
