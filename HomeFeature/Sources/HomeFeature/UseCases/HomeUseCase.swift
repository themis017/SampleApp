//
//  HomeUseCase.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol HomeUseCaseProviding {

    var recipes: Observable<[Recipe]> { get }
    
    func refresh()
    func showRecipe(_ recipe: Recipe)
}

public class HomeUseCase: HomeUseCaseProviding {
        
    public let recipes: Observable<[Recipe]>
    
    private let homeRouter: any HomeRouting
    
    public init(homeRouter: any HomeRouting) {
        self.homeRouter = homeRouter
        
        self.recipes = Observable(initialValue: [])
        
        findRecipes()
    }
    
    private func findRecipes() {
        
        // MARK: Perform request to find recipes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.recipes.value = Recipe.previewExamples
        }
    }
    
    public func refresh() {
        findRecipes()
    }
    
    public func showRecipe(_ recipe: Recipe) {
        homeRouter.showRecipe(recipe)
    }
    
}

#if DEBUG

public class PreviewHomeUseCase: HomeUseCaseProviding {
    
    public var recipes: Observable<[Recipe]>
    
    public init() {
        self.recipes = .init(initialValue: Recipe.previewExamples)
    }
    
    public func refresh() {}
    public func showRecipe(_ recipe: Recipe) {}
}

#endif
