//
//  UINavigationController+UIGestureRecognizer.swift
//  SampleApp
//
//  Created by Themis Makedas on 3/1/24.
//

import Foundation
import UIKit
import SwiftUI
import ApplicationLayer
import MainFeature

extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard viewControllers.count > 1 else {
            return false
        }
        
        guard let lastViewController = viewControllers.last as? RoutingUIHostingController<AnyView>,
              !lastViewController.isRoot else {
            return false
        }
        
        if let tabBarCategory = lastViewController.tabCategory {
            removeTopController(of: tabBarCategory)
        }
        
        return true
    }
    
    private func removeTopController(of tabBarCategory: TabBarCategory) {
        switch tabBarCategory {
        case .home, .search, .favourites, .profile:
            TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] = TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory]?.dropLast()
        case .upload:
            break
        }
    }
}
