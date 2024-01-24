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
        case nextAction
    }
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    private let searchUseCase: SearchUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(searchUseCase: SearchUseCaseProviding) {
        self.randomProperty = searchUseCase.randomProperty.value
        self.searchUseCase = searchUseCase
        
        bind(\.randomProperty, to: searchUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: searchUseCase.randomText)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            searchUseCase.nextAction()
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
