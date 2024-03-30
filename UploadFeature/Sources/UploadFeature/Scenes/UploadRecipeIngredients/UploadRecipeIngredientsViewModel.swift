//
//  UploadRecipeIngredientsViewModel.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeIngredientsViewModel: ViewModel {
    
    public enum Action {
        case showRecipeMethod
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
        case .showRecipeMethod:
            break
//            uploadRecipeUseCase.showRecipeMethod()
        }
    }
    
    public func makeUploadRecipeMethodViewModel() -> UploadRecipeMethodViewModel {
        UploadRecipeMethodViewModel(uploadRecipeUseCase: uploadRecipeUseCase)
    }
}

#if DEBUG

public extension UploadRecipeIngredientsViewModel {
    
    static func previewViewModel() -> UploadRecipeIngredientsViewModel {
        let previewUseCase = PreviewUploadRecipeUseCase()
        return UploadRecipeIngredientsViewModel(uploadRecipeUseCase: previewUseCase)
    }
}

#endif
