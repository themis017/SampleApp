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
    var searchedRecipes: Observable<[Recipe]> { get }
    var popularUsers: Observable<[UserProfile]> { get }
    var searchedUsers: Observable<[UserProfile]> { get }
    var searchFilter: Observable<SearchFilter> { get }
        
    func showRecipe(_ recipe: Recipe)
    func showUserProfile(_ user: UserProfile)
    func removeUser(_ user: UserProfile)
    func searchResults(for query: String)
}

public class SearchUseCase: SearchUseCaseProviding {
        
    public let popularRecipes: Observable<[Recipe]>
    public let searchedRecipes: Observable<[Recipe]>
    public let popularUsers: Observable<[UserProfile]>
    public let searchedUsers: Observable<[UserProfile]>
    public let searchFilter: Observable<SearchFilter>
        
    private var subscriptions: Set<AnyCancellable> = []
    
    private let searchRouter: any SearchRouting
    
    public init(searchRouter: any SearchRouting) {
        
        self.popularRecipes = Observable(initialValue: [])
        self.searchedRecipes = Observable(initialValue: [])
        self.popularUsers = Observable(initialValue: [])
        self.searchedUsers = Observable(initialValue: [])
        self.searchFilter = Observable(initialValue: .recipes)

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
    
    public func searchResults(for query: String) {
        switch searchFilter.value {
        case .recipes:
            searchRecipes(for: query)
        case .users:
            searchUsers(for: query)
        }
    }
    
    private func searchRecipes(for query: String) {
        let totalRecipes = Recipe.previewHomeExamples
        
        searchedRecipes.value = totalRecipes.filter({ $0.title.rawValue.lowercased().contains(query.lowercased()) })
    }
    
    private func searchUsers(for query: String) {
        let totalUsers = UserProfile.popularUsers
        
        searchedUsers.value = totalUsers.filter({ $0.name.rawValue.lowercased().contains(query.lowercased()) })
    }
}

#if DEBUG

public class PreviewSearchUseCase: SearchUseCaseProviding {
    
    public var popularRecipes: Observable<[Recipe]>
    public var searchedRecipes: Observable<[Recipe]>
    public var popularUsers: Observable<[UserProfile]>
    public var searchedUsers: Observable<[UserProfile]>
    public var searchFilter: Observable<SearchFilter>
        
    public init() {
        self.popularRecipes = Observable(initialValue: Recipe.previewHomeExamples)
        self.searchedRecipes = Observable(initialValue: Recipe.previewHomeExamples)
        self.popularUsers = Observable(initialValue: UserProfile.popularUsers)
        self.searchedUsers = Observable(initialValue: UserProfile.popularUsers)
        self.searchFilter = Observable(initialValue: .recipes)
    }
    
    public func showRecipe(_ recipe: Recipe) {}
    public func showUserProfile(_ user: UserProfile) {}
    public func removeUser(_ user: UserProfile) {}
    public func searchResults(for query: String) {}
}

#endif
