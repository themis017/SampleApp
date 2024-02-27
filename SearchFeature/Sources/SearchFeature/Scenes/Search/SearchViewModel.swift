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
    
//    @Published
//    var temp: Int?
    
    private let searchUseCase: SearchUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(searchUseCase: SearchUseCaseProviding) {
//        self.temp = searchUseCase.temp.value
        self.searchUseCase = searchUseCase
        
//        bind(\.temp, to: searchUseCase.temp)
//            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            searchUseCase.action()
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
