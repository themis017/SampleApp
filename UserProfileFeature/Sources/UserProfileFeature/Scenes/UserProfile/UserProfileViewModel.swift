//
//  UserProfileViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

@MainActor
public class UserProfileViewModel: ObservableObject {
    
    public enum Action {
        case showFirstSettings
    }
    
    private let userProfileUseCase: UserProfileUseCaseProviding
   
    init(userProfileUseCase: UserProfileUseCaseProviding) {
        self.userProfileUseCase = userProfileUseCase
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
