//
//  UserProfileViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import UILayer

@MainActor
public class UserProfileViewModel: ViewModel {
    
    public enum Action {
        case showFirstSettings
    }
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    private let userProfileUseCase: UserProfileUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(userProfileUseCase: UserProfileUseCaseProviding) {
        self.randomProperty = userProfileUseCase.randomProperty.value
        self.userProfileUseCase = userProfileUseCase
        
        bind(\.randomProperty, to: userProfileUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: userProfileUseCase.randomText)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showFirstSettings:
            userProfileUseCase.showSettingsScene()
        }
    }
}

#if DEBUG

public extension UserProfileViewModel {
    
    static func previewViewModel() -> UserProfileViewModel {
        let previewUseCase = PreviewUserProfileUseCase()
        return UserProfileViewModel(userProfileUseCase: previewUseCase)
    }
}

#endif
