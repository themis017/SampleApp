//
//  PushPresentation.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import UIKit

final class PushPresentation: NSObject {
    var isAnimated: Bool = true

    private weak var from: UIViewController?
    private var openCompletionHandler: (() -> Void)?
    private var closeCompletionHandler: (() -> Void)?

    private var navigationController: UINavigationController? {
        guard let navigation = from as? UINavigationController else {
            return from?.navigationController
        }
        
        return navigation
    }

    init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension PushPresentation: Presentation {
    
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        openCompletionHandler = completion
        navigationController?.delegate = self
//        navigationController?.present(viewController, animated: isAnimated, completion: completion)
        navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        closeCompletionHandler = completion
        navigationController?.popViewController(animated: isAnimated)
    }
}

extension PushPresentation: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let transitionCoordinator = navigationController.transitionCoordinator,
              let fromVC = transitionCoordinator.viewController(forKey: .from),
              let toVC = transitionCoordinator.viewController(forKey: .to) else {
            return
        }

        if fromVC == from {
            openCompletionHandler?()
            openCompletionHandler = nil
        } else if toVC == from {
            closeCompletionHandler?()
            closeCompletionHandler = nil
        }
    }
}
