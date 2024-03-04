//
//  SearchViewModel.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class SearchViewModel: ViewModel {
    
    public enum Action {
        case showRecipe(Recipe)
        case showUser(UserProfile)
        case removeUser(UserProfile)
    }

    @Published
    public var popularRecipes: [Recipe]
    
    @Published
    public var popularUsers: [UserProfile]
    
    @Published
    public var searchFilter: SearchFilter = .recipes
    
    private let searchUseCase: SearchUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(searchUseCase: SearchUseCaseProviding) {
        self.searchUseCase = searchUseCase
        self.popularRecipes = searchUseCase.popularRecipes.value
        self.popularUsers = searchUseCase.popularUsers.value
        
        bind(\.popularRecipes, to: searchUseCase.popularRecipes)
            .store(in: &subscriptions)
        
        bind(\.popularUsers, to: searchUseCase.popularUsers, animatedBy: .default)
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
