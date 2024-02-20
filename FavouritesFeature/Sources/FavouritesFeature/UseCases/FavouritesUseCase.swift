//
//  FavouritesUseCase.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol FavouritesUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    var recipes: Observable<[Recipe]?> { get }
    
    func showRecipe(_ recipe: Recipe)
    func removeRecipe()
}

public class FavouritesUseCase: FavouritesUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let recipes: Observable<[Recipe]?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let favouritesRouter: any FavouritesRouting
    
    public init(favouritesRouter: any FavouritesRouting) {
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.recipes = Observable(initialValue: AppData.shared.value(of: .favourites))
        
        self.favouritesRouter = favouritesRouter
        
        AppData.shared
            .userProfilePublisher
            .sink { [weak self] newValue in
                self?.userProfile.value = newValue
            }
            .store(in: &subscriptions)
        
        AppData.shared
            .favouritesPublisher
            .sink { [weak self] newValue in
                self?.recipes.value = newValue
            }
            .store(in: &subscriptions)
        
        if userProfile.value == nil {
            loadUserProfile()
        }
        
        if recipes.value == nil {
            loadFavourites()
        }
    }
    
    private func loadUserProfile() {
        userProfile.value = UserProfile.principalUser
    }
    
    private func loadFavourites() {
        recipes.value = Recipe.previewFavouritesExamples
    }
    
    public func showRecipe(_ recipe: Recipe) {
        favouritesRouter.showRecipe(recipe)
    }
    
    public func removeRecipe() {
        
    }
    
}

#if DEBUG

public class PreviewFavouritesUseCase: FavouritesUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var recipes: Observable<[Recipe]?>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.recipes = Observable(initialValue: Recipe.previewFavouritesExamples)
    }
    
    public func showRecipe(_ recipe: Recipe) {}
    public func removeRecipe() {}
}

#endif
