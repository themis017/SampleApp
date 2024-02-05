//
//  HomeViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class HomeViewModel: ViewModel {
    
    public enum Action {
        case randomAction
    }
    
    private let homeUseCase: HomeUseCaseProviding
    
    public init(homeUseCase: HomeUseCaseProviding) {
        self.homeUseCase = homeUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .randomAction:
            homeUseCase.randomAction()
        }
    }
}

#if DEBUG

public extension HomeViewModel {
    
    static func previewViewModel() -> HomeViewModel {
        let previewUseCase = PreviewHomeUseCase()
        return HomeViewModel(homeUseCase: previewUseCase)
    }
}

#endif
