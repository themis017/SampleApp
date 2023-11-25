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
//        // Prewarm User Defaults
//        UserDefaultsStorage.applicationLaunched()
    }
    
//    func registerSystemServices(into systemServiceExecutor: SystemServiceExecutor) {
//        systemServiceExecutor.register(service: SystemMonitoringService())
//    }
//    
//    func didLaunch(application: Application) {
//        // Prewarm Dependencies
//        let _ = Resolver.resolve(PrincipalUserResolverService.self)
//        let _ = Resolver.resolve(BrazeEventsService.self)
//        let _ = Resolver.resolve(UserTrackingService.self)
//        let _ = Resolver.resolve(AppIdentityService.self)
//        
//        // Notify service executor that system composition is complete
//        iOSSystemServiceExecutor.shared.willLaunch()
//        DeveloperToolsInspectors.shared.notifyLaunched()
//    }
}
