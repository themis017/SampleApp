//
//  EmptyPresentation.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import UIKit

final class EmptyPresentation {
    var isAnimated: Bool = true
}

extension EmptyPresentation: Presentation {

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
