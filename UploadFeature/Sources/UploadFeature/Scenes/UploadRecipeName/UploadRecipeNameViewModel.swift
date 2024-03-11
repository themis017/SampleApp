//
//  UploadRecipeNameViewModel.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeNameViewModel: ViewModel {
    
    public enum Action {
        case continueAction
    }
    
    @Published
    var userProfile: UserProfile?
    
    private let uploadRecipeUseCase: UploadRecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(uploadRecipeUseCase: UploadRecipeUseCaseProviding) {
        self.uploadRecipeUseCase = uploadRecipeUseCase
        
        self.userProfile = uploadRecipeUseCase.userProfile.value
        
        bind(\.userProfile, to: uploadRecipeUseCase.userProfile)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .continueAction:
            break
        }
    }
}

#if DEBUG

public extension UploadRecipeNameViewModel {
    
    static func previewViewModel() -> UploadRecipeNameViewModel {
        let previewUseCase = PreviewUploadRecipeUseCase()
        return UploadRecipeNameViewModel(uploadRecipeUseCase: previewUseCase)
    }
}

#endif
