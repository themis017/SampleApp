//
//  UINavigationController+UIGestureRecognizer.swift
//  SampleApp
//
//  Created by Themis Makedas on 3/1/24.
//

import Foundation
import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
