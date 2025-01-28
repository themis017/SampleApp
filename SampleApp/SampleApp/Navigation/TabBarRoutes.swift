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
    
    var tabBarRoutingControllers: [TabBarCategory: [RoutingUIHostingController<AnyView>]]
    
    init() {
        var tabBarRoutingControllers: [TabBarCategory: [RoutingUIHostingController<AnyView>]] = [:]
        TabBarCategory.allCases.forEach { tabBarCategory in
            tabBarRoutingControllers[tabBarCategory] = []
        }
        
        self.tabBarRoutingControllers = tabBarRoutingControllers
    }
}
