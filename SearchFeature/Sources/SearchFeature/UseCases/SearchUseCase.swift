//
//  SearchUseCase.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol SearchUseCaseProviding {
        
    var popularRecipes: Observable<[Recipe]> { get }
    var popularUsers: Observable<[UserProfile]> { get }
        
    func showRecipe(_ recipe: Recipe)
    func showUserProfile(_ user: UserProfile)
    func removeUser(_ user: UserProfile)
}

public class SearchUseCase: SearchUseCaseProviding {
        
    public let popularRecipes: Observable<[Recipe]>
    public let popularUsers: Observable<[UserProfile]>
        
    private var subscriptions: Set<AnyCancellable> = []
    
    private let searchRouter: any SearchRouting
    
    public init(searchRouter: any SearchRouting) {
        
        self.popularRecipes = Observable(initialValue: [])
        self.popularUsers = Observable(initialValue: [])

        self.searchRouter = searchRouter
        
        loadData()
    }
    
    private func loadData() {
        popularRecipes.value = Recipe.previewHomeExamples
        popularUsers.value = UserProfile.popularUsers
    }
    
    public func showRecipe(_ recipe: Recipe) {
        searchRouter.showRecipe(recipe)
    }
    
    public func showUserProfile(_ user: UserProfile) {
        searchRouter.showUser(UserReference(id: user.id))
    }
    
    public func removeUser(_ user: UserProfile) {
        guard let userIndex = popularUsers.value.firstIndex(of: user) else {
            return
        }
        
        popularUsers.value.remove(at: userIndex)
    }
}

#if DEBUG

public class PreviewSearchUseCase: SearchUseCaseProviding {
    
    public var popularRecipes: Observable<[Recipe]>
    public var popularUsers: Observable<[UserProfile]>
        
    public init() {
        self.popularRecipes = Observable(initialValue: Recipe.previewHomeExamples)
        self.popularUsers = Observable(initialValue: UserProfile.popularUsers)
    }
    
    public func showRecipe(_ recipe: Recipe) {}
    public func showUserProfile(_ user: UserProfile) {}
    public func removeUser(_ user: UserProfile) {}
}

#endif
