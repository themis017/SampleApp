//
//  UserProfile_A_ViewModel.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UserProfile_A_ViewModel: ViewModel {
    
    public enum Action {
        case nextAction
    }
    
    @Published
    var selectedTab: TabBarCategory = .home
    
    private let userProfile_A_UseCase: UserProfile_A_UseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(userProfile_A_UseCase: UserProfile_A_UseCaseProviding) {
        
        self.userProfile_A_UseCase = userProfile_A_UseCase
        
//        $selectedTab
//            .sink { newValue in
//                print("### selectedTab: \(newValue)")
//            }
//            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            userProfile_A_UseCase.nextAction()
        }
    }
}

#if DEBUG

public extension UserProfile_A_ViewModel {
    
    static func previewViewModel() -> UserProfile_A_ViewModel {
        let previewUseCase = PreviewUserProfile_A_UseCase()
        return UserProfile_A_ViewModel(userProfile_A_UseCase: previewUseCase)
    }
}

#endif
