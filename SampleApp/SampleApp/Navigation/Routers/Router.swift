//
//  Router.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import UIKit

//protocol Deeplinkable: class {
//    /// Route to a view controller applying the transition provided by resolving the URL to a specific Route.
//    @discardableResult
//    func route(to url: URL, as transition: Transition) -> Bool
//}


protocol Router {
    /// The root view controller of this router.
    var root: UIViewController? { get set }

    /// Closes the Router's root view controller using the presentation used to show it.
    func close()

    /// Closes the Router's root view controller using the presentation used to show it.
    func close(completion: (() -> Void)?)
    
    /// Dismisses the Router's root view controller ignoring the presentation used to show it.
    func dismiss()

    /// Dismisses the Router's root view controller ignoring the presentation used to show it.
    func dismiss(completion: (() -> Void)?)
    
    /// Route to a view controller using the presentation provided.
    func route(to viewController: UIViewController, as presentation: Presentation)

    /// Route to  a view controller using the presentation provided.
    func route(to viewController: UIViewController, as presentation: Presentation, completion: (() -> Void)?)
}
