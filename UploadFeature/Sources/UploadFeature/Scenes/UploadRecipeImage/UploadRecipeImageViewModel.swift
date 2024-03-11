//
//  UploadRecipeImageViewModel.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeImageViewModel: ViewModel {
    
    public enum Action {
        case showUploadRecipeName
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var showUploadRecipeName: Bool = false
    
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
        case .showUploadRecipeName:
            showUploadRecipeName = true
        }
    }
    
    public func makeUploadRecipeNameViewModel() -> UploadRecipeNameViewModel {
        UploadRecipeNameViewModel(uploadRecipeUseCase: uploadRecipeUseCase)
    }
}

#if DEBUG

public extension UploadRecipeImageViewModel {
    
    static func previewViewModel() -> UploadRecipeImageViewModel {
        let previewUseCase = PreviewUploadRecipeUseCase()
        return UploadRecipeImageViewModel(uploadRecipeUseCase: previewUseCase)
    }
}

#endif
