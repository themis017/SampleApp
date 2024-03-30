//
//  UploadRecipeMethodViewModel.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeMethodViewModel: ViewModel {
    
    public enum Action {
        case upload
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
        case .upload:
            break
//            uploadRecipeUseCase.upload()
        }
    }
}

#if DEBUG

public extension UploadRecipeMethodViewModel {
    
    static func previewViewModel() -> UploadRecipeMethodViewModel {
        let previewUseCase = PreviewUploadRecipeUseCase()
        return UploadRecipeMethodViewModel(uploadRecipeUseCase: previewUseCase)
    }
}

#endif
