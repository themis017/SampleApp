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
        case nextAction
        case saveUsername
    }
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    @Published
    var newUsername: String
    
    private let userProfileUseCase: UserProfileUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(userProfileUseCase: UserProfileUseCaseProviding) {
        self.randomProperty = userProfileUseCase.randomProperty.value
        self.newUsername = userProfileUseCase.appDataUsername.value
        
        self.userProfileUseCase = userProfileUseCase
        
        bind(\.randomProperty, to: userProfileUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: userProfileUseCase.randomText)
            .store(in: &subscriptions)

    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            userProfileUseCase.nextAction()
        case .saveUsername:
            userProfileUseCase.saveUsername(to: newUsername)
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
