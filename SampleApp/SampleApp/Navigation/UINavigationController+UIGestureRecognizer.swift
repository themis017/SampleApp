//
//  UINavigationController+UIGestureRecognizer.swift
//  SampleApp
//
//  Created by Themis Makedas on 3/1/24.
//

import Foundation
import UIKit
import HomeFeature

extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard viewControllers.count > 1 else {
            return false
        }
        
        guard let lastViewControllerTitle = viewControllers.last?.title,
              lastViewControllerTitle != HomeView.sceneIdentity else {
            return false
        }
        
        return true
    }
}
