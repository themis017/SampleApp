//
//  UploadRecipeInfoViewModel.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeInfoViewModel: ViewModel {
    
    public enum Action {
        case dismiss
    }
    
    @Published
    var userProfile: UserProfile?
    
    @RecipeTitleValidated
    var recipeTitle: String = ""
    
    @Published
    var recipeTitleError: RecipeTitleValueError? = .emptyValue
    
    public var isContinueEnabled: Bool {
        recipeTitleError == nil
    }
    
    private let uploadRecipeUseCase: UploadRecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(uploadRecipeUseCase: UploadRecipeUseCaseProviding) {
        self.uploadRecipeUseCase = uploadRecipeUseCase
        
        self.userProfile = uploadRecipeUseCase.userProfile.value
        
        bind(\.userProfile, to: uploadRecipeUseCase.userProfile)
            .store(in: &subscriptions)
        
        forward(_recipeTitle.recipeTitlePublisher, to: uploadRecipeUseCase.recipeTitle)
            .store(in: &subscriptions)
        
        _recipeTitle.recipeTitleErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recipeTitleValueError in
                self?.recipeTitleError = recipeTitleValueError
            }
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .dismiss:
            uploadRecipeUseCase.dismiss()
        }
    }
    
    public func makeUploadRecipeIngredientsViewModel() -> UploadRecipeIngredientsViewModel {
        UploadRecipeIngredientsViewModel(uploadRecipeUseCase: uploadRecipeUseCase)
    }
}

#if DEBUG

public extension UploadRecipeInfoViewModel {
    
    static func previewViewModel() -> UploadRecipeInfoViewModel {
        let previewUseCase = PreviewUploadRecipeUseCase()
        return UploadRecipeInfoViewModel(uploadRecipeUseCase: previewUseCase)
    }
}

#endif
