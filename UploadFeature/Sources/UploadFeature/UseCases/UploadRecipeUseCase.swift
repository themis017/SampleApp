//
//  UploadRecipeUseCase.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol UploadRecipeUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
       
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.uploadRouter = uploadRouter
        
        AppData.shared
            .userProfilePublisher
            .sink { [weak self] newValue in
                self?.userProfile.value = newValue
            }
            .store(in: &subscriptions)
    }
    
    private func loadUserProfile() {
        userProfile.value = UserProfile.principalUser
    }
    
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
    }
    
}

#endif
