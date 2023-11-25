//
//  iOSApplication.swift
//  SampleApp
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation
import ApplicationLayer
import Resolver
import SwiftUI
import UILayer

struct iOSApplication: AppFeatureModule {
    
    init() {
        
#if DEBUG
        print("Loaded environment configuration.")
#endif
    }
    
    var feature: AppFeature {
        AppFeature("iOSApplication") { container in
            
        }
    }
    
    func willLaunchApplication() {

    }

    func didLaunch(application: Application) {

    }
}
