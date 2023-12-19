//
//  BaseRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import UIKit

class BaseRouter: NSObject, Router { 
    private let rootPresentation: Presentation
    weak var root: UIViewController?

    init(rootPresentation: Presentation) {
        self.rootPresentation = rootPresentation
    }

    deinit {
        print("🗑 Deallocating \(self) with \(String(describing: rootPresentation))")
    }


    func route(to viewController: UIViewController, as presentation: Presentation, completion: (() -> Void)?) {
        guard let root = root else {
            return
        }
        
        presentation.open(viewController, from: root, completion: completion)
    }

    func route(to viewController: UIViewController, as presentation: Presentation) {
        route(to: viewController, as: presentation, completion: nil)
    }

    func close(completion: (() -> Void)?) {
        guard let root = root else {
            return
        }
        
        // Removes the `root` with the same transition that it was opened.
        rootPresentation.close(root, completion: completion)
    }

    func close() {
        close(completion: nil)
    }

    func dismiss(completion: (() -> Void)?) {
        // Dismiss the root with iOS' default dismiss animation.
        // It will only work if the root or its ancestor were presented
        // using iOS' native present view controller method.
        root?.dismiss(animated: rootPresentation.isAnimated, completion: completion)
    }

    func dismiss() {
        dismiss(completion: nil)
    }
}
