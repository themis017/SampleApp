//
//  UserProfile_B_ViewModel.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UserProfile_B_ViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory = .profile
    
    private let userProfile_B_UseCase: UserProfile_B_UseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(userProfile_B_UseCase: UserProfile_B_UseCaseProviding) {
        
        self.userProfile_B_UseCase = userProfile_B_UseCase
        
//        $selectedTab
//            .dropFirst()
//            .sink { [weak self] newValue in
//                print("### selectedTab: \(newValue)")
//                self?.userProfile_B_UseCase.showPath(for: newValue)
//            }
//            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            userProfile_B_UseCase.showPath(for: tabCategory)
        case .dismiss:
            userProfile_B_UseCase.dismiss()
        case .nextAction:
            userProfile_B_UseCase.nextAction()
        }
    }
}

#if DEBUG

public extension UserProfile_B_ViewModel {
    
    static func previewViewModel() -> UserProfile_B_ViewModel {
        let previewUseCase = PreviewUserProfile_B_UseCase()
        return UserProfile_B_ViewModel(userProfile_B_UseCase: previewUseCase)
    }
}

#endif
