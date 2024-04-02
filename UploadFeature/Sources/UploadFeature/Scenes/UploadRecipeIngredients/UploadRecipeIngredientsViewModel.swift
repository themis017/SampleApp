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
        case dismiss
        case showRecipeMethod
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var ingredients: String = "\u{2022}"
    
    private var previousIngredients: String = "\u{2022}"
    
    @Published
    var ingredientsValueError: NoneValueError?
    
    private let uploadRecipeUseCase: UploadRecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(uploadRecipeUseCase: UploadRecipeUseCaseProviding) {
        self.uploadRecipeUseCase = uploadRecipeUseCase
        
        self.userProfile = uploadRecipeUseCase.userProfile.value
        
        bind(\.userProfile, to: uploadRecipeUseCase.userProfile)
            .store(in: &subscriptions)
        
        forward($ingredients, to: uploadRecipeUseCase.ingredients)
            .store(in: &subscriptions)
        
//        $ingredients
//            .sink { [weak self] newValue in
//                                
//                guard let self = self,
//                      newValue.suffix(1) == "\n" && newValue > self.previousIngredients else {
//                    
////                    self?.ingredients.append("2")
//                    self?.previousIngredients = newValue
//                    return
//                }
//                
//                self.ingredients.append("1")//.append("\u{2022}")
//                self.previousIngredients = self.ingredients
//            }
//            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .dismiss:
            uploadRecipeUseCase.dismiss()
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
