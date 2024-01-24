//
//  HomeDetails_B_ViewModel.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class HomeDetails_B_ViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory = .home
    
    private let homeDetails_B_UseCase: HomeDetails_B_UseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(homeDetails_B_UseCase: HomeDetails_B_UseCaseProviding) {
        
        self.homeDetails_B_UseCase = homeDetails_B_UseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            homeDetails_B_UseCase.showPath(for: tabCategory)
        case .dismiss:
            homeDetails_B_UseCase.dismiss()
        case .nextAction:
            homeDetails_B_UseCase.nextAction()
        }
    }
}

#if DEBUG

public extension HomeDetails_B_ViewModel {
    
    static func previewViewModel() -> HomeDetails_B_ViewModel {
        let previewUseCase = PreviewHomeDetails_B_UseCase()
        return HomeDetails_B_ViewModel(homeDetails_B_UseCase: previewUseCase)
    }
}

#endif
