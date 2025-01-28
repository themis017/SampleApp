//
//  BaseRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 26/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UploadFeature

open class BaseRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor
    public func showUploadScene() {
        let uploadRouter = UploadRouter(navigationController: navigationController)
        let useCase = UploadRecipeUseCase(uploadRouter: uploadRouter)
        let viewModel = UploadRecipeImageViewModel(uploadRecipeUseCase: useCase)
        let view = UploadRecipeImageView(viewModel: viewModel)
        
        let viewController = RoutingUIHostingController(
            sceneIdentity: UploadRecipeImageView.sceneIdentity,
            isRoot: false,
            tabCategory: .upload,
            view: AnyView(view))
        
        append(viewController, for: .upload)
        self.navigationController.present(viewController, animated: true)
    }
    
    @MainActor
    public func popScene(animated: Bool) {
        if let routingController = navigationController.topViewController as? RoutingUIHostingController<AnyView>,
           !routingController.isRoot {
            
            if let tabBarCategory = routingController.tabCategory,
               let tabBarRoutingControllers = TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory],
               tabBarRoutingControllers.count > 0 {
                
                TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] = tabBarRoutingControllers.dropLast()
            }

            DispatchQueue.main.async {
                self.navigationController.popViewController(animated: animated)
            }
        }
    }
    
    @MainActor
    public func dismissSheet(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: animated, completion: nil)
        }
    }
    
    @MainActor
    public func dismissToRoot(for selectedTab: TabBarCategory) {
        TabBarRoutes.shared.tabBarRoutingControllers[selectedTab] = []
        removeViewControllers(for: selectedTab)
    }
    
    @MainActor
    public func showPath(for selectedTab: TabBarCategory) {
        
        updateTabBarCategoriesControllers()
        
        guard var routingViewControllers = TabBarRoutes.shared.tabBarRoutingControllers[selectedTab] else {
            return
        }
        
        self.navigationController.viewControllers.removeAll { viewController in
            guard let routingUIHostingController = viewController as? RoutingUIHostingController<AnyView>,
                  routingUIHostingController.isRoot else {
                return true
            }
            
            return false
        }
                    
        routingViewControllers = routingViewControllers.reversed()
        var viewControllersCount = routingViewControllers.count
        
        for routingViewController in routingViewControllers {
            if viewControllersCount == routingViewControllers.count {
                self.navigationController.pushViewController(routingViewController, animated: false)
                viewControllersCount -= 1
                continue
            }
            
            if viewControllersCount == 0 {
                break
            } else {
                self.navigationController.viewControllers.insert(routingViewController, at: 1)
            }
            
            viewControllersCount -= 1
        }
        
        insertOtherTabBarCategoriesControllers(of: selectedTab)
    }
    
    private func updateTabBarCategoriesControllers() {
        
        for tabBarCategory in TabBarCategory.allCases {
            if tabBarCategory == .upload {
                continue
            }
            
            let tabBarCategoryControllers = self.navigationController.viewControllers.filter { viewController in
                guard let routingUIHostingController = viewController as? RoutingUIHostingController<AnyView>,
                      routingUIHostingController.tabCategory == tabBarCategory else {
                    return false
                }
                
                return true
            }
            
            if !tabBarCategoryControllers.isEmpty {
                TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] = tabBarCategoryControllers.map({ $0 as? RoutingUIHostingController<AnyView>}).compactMap({ $0 })
            }
        }
    }
    
    private func insertOtherTabBarCategoriesControllers(of selectedTab: TabBarCategory) {
        
        for tabBarCategory in TabBarCategory.allCases {
            
            if tabBarCategory != selectedTab,
               let categoryRoutingViewControllers = TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory],
               !categoryRoutingViewControllers.isEmpty {
                
                for categoryRoutingViewController in categoryRoutingViewControllers {
                    self.navigationController.viewControllers.insert(categoryRoutingViewController, at: 0)
                }
            }
        }
    }
    
    private func removeViewControllers(for selectedTab: TabBarCategory) {
        self.navigationController.viewControllers.removeAll { viewController in
            guard let routingController = viewController as? RoutingUIHostingController<AnyView>,
                  routingController.tabCategory == selectedTab  else {
                return false
            }
            
            return true
        }
    }
    
    func append(_ routingViewController: RoutingUIHostingController<AnyView>, for tabBarCategory: TabBarCategory) {
        guard var currentRoutingViewControllers = TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] else {
            TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] = [routingViewController]
            return
        }
        
        currentRoutingViewControllers.append(routingViewController)
        TabBarRoutes.shared.tabBarRoutingControllers[tabBarCategory] = currentRoutingViewControllers
    }
}
