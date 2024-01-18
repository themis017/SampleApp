//
//  TabBarRoutes.swift
//  SampleApp
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public class TabBarRoutes {
    
    public static let shared = TabBarRoutes()
    
    var homeRoutingControllers: [RoutingUIHostingController<AnyView>]
    var searchRoutingControllers: [RoutingUIHostingController<AnyView>]
    var notificationsRoutingControllers: [RoutingUIHostingController<AnyView>]
    var profileRoutingControllers: [RoutingUIHostingController<AnyView>]
    
    init(homeRoutingControllers: [RoutingUIHostingController<AnyView>] = [],
         searchRoutingControllers: [RoutingUIHostingController<AnyView>] = [],
         notificationsRoutingControllers: [RoutingUIHostingController<AnyView>] = [],
         profileRoutingControllers: [RoutingUIHostingController<AnyView>] = []) {
        
        self.homeRoutingControllers = homeRoutingControllers
        self.searchRoutingControllers = searchRoutingControllers
        self.notificationsRoutingControllers = notificationsRoutingControllers
        self.profileRoutingControllers = profileRoutingControllers
    }
}
