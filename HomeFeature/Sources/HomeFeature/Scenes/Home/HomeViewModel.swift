//
//  HomeViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

@MainActor
public class HomeViewModel: ObservableObject {
    
    public enum Action {
        case showProfile
    }
    
    private let homeUseCase: HomeUseCaseProviding
   
    public init(homeUseCase: HomeUseCaseProviding) {
        self.homeUseCase = homeUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showProfile:
            homeUseCase.showProfileScene()
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
