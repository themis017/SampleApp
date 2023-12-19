//
//  Presentation.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import UIKit

protocol Presentation {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
