//
//  SearchViewModel.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import SwiftUI
import ApplicationLayer
import UILayer

@MainActor
public class SearchViewModel: ViewModel {
    
    public enum Action {
        case showRecipe(Recipe)
        case showUser(UserProfile)
        case removeUser(UserProfile)
        case changeFilter(to: SearchFilter)
        case searchResults
    }

    @Published
    public var popularRecipes: [Recipe]
    
    @Published
    public var searchedRecipes: [Recipe]
    
    @Published
    public var popularUsers: [UserProfile]
    
    @Published
    public var searchedUsers: [UserProfile]
    
    @Published
    public var searchFilter: SearchFilter
    
    @Published
    public var searchQuery: String = ""
    
    public var isSearching: Bool {
        searchQuery.isNotEmpty()
    }
    
    private let searchUseCase: SearchUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(searchUseCase: SearchUseCaseProviding) {
        self.searchUseCase = searchUseCase
        self.popularRecipes = searchUseCase.popularRecipes.value
        self.searchedRecipes = searchUseCase.searchedRecipes.value
        self.popularUsers = searchUseCase.popularUsers.value
        self.searchedUsers = searchUseCase.searchedUsers.value
        self.searchFilter = searchUseCase.searchFilter.value
        
        bind(\.popularRecipes, to: searchUseCase.popularRecipes)
            .store(in: &subscriptions)
        
        bind(\.searchedRecipes, to: searchUseCase.searchedRecipes, animatedBy: .default)
            .store(in: &subscriptions)
        
        bind(\.popularUsers, to: searchUseCase.popularUsers, animatedBy: .default)
            .store(in: &subscriptions)
        
        bind(\.searchedUsers, to: searchUseCase.searchedUsers, animatedBy: .default)
            .store(in: &subscriptions)
        
        forward($searchFilter, to: searchUseCase.searchFilter)
            .store(in: &subscriptions)
        
        $searchQuery
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink{ [weak self] newValue in
                self?.searchUseCase.searchResults(for: newValue)
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showRecipe(let recipe):
            searchUseCase.showRecipe(recipe)
        case .showUser(let userProfile):
            searchUseCase.showUserProfile(userProfile)
        case .removeUser(let userProfile):
            searchUseCase.removeUser(userProfile)
        case .changeFilter(to: let newSearchFilter):
            withAnimation {
                searchFilter = newSearchFilter
            }
        case .searchResults:
            searchUseCase.searchResults(for: searchQuery)
        }
    }
}

#if DEBUG

public extension SearchViewModel {
    
    static func previewViewModel() -> SearchViewModel {
        let previewUseCase = PreviewSearchUseCase()
        return SearchViewModel(searchUseCase: previewUseCase)
    }
}

#endif
