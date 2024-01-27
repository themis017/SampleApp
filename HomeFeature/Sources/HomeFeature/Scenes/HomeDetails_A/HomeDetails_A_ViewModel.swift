//
//  HomeDetails_A_ViewModel.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class HomeDetails_A_ViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss(animated: Bool)
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory = .home
    
    private let homeDetails_A_UseCase: HomeDetails_A_UseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(homeDetails_A_UseCase: HomeDetails_A_UseCaseProviding) {
        
        self.homeDetails_A_UseCase = homeDetails_A_UseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            guard tabCategory != .upload else {
                homeDetails_A_UseCase.showUpload()
                return
            }
            
//            selectedTab = tabCategory
            homeDetails_A_UseCase.showPath(for: tabCategory)
        case .dismiss(let animated):
            homeDetails_A_UseCase.dismiss(animated: animated)
        case .nextAction:
            homeDetails_A_UseCase.nextAction()
        }
    }
}

#if DEBUG

public extension HomeDetails_A_ViewModel {
    
    static func previewViewModel() -> HomeDetails_A_ViewModel {
        let previewUseCase = PreviewHomeDetails_A_UseCase()
        return HomeDetails_A_ViewModel(homeDetails_A_UseCase: previewUseCase)
    }
}

#endif