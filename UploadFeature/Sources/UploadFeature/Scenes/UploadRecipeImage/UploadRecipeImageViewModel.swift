//
//  UploadRecipeImageViewModel.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import SwiftUI
import ApplicationLayer
import UILayer

@MainActor
public class UploadRecipeImageViewModel: ViewModel {
    
    public enum Action {
        case selectedPhotoLibrary
        case selectedCamera
        case showRecipeImage
        case showUploadRecipeName
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var selectedImage: UIImage?
    
    @Published
    var uploadRecipeImageScene: UploadRecipeImageScene
    
    @Published
    var isConfirmationDialogPresented: Bool = false
    
    var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Published
    var showUploadRecipeName: Bool = false
    
    private let uploadRecipeUseCase: UploadRecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(uploadRecipeUseCase: UploadRecipeUseCaseProviding) {
        self.uploadRecipeUseCase = uploadRecipeUseCase
        
        self.userProfile = uploadRecipeUseCase.userProfile.value
        self.uploadRecipeImageScene = uploadRecipeUseCase.uploadRecipeImageScene.value

        bind(\.userProfile, to: uploadRecipeUseCase.userProfile)
            .store(in: &subscriptions)
        
        bind(\.uploadRecipeImageScene, to: uploadRecipeUseCase.uploadRecipeImageScene, animatedBy: .default)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedPhotoLibrary:
            pickerSourceType = .photoLibrary
            isConfirmationDialogPresented = false
            uploadRecipeUseCase.checkPhotoLibraryPermission()
        case .selectedCamera:
            pickerSourceType = .camera
            isConfirmationDialogPresented = false
            uploadRecipeUseCase.checkCameraPermission()
        case .showRecipeImage:
            uploadRecipeUseCase.showRecipeImage()
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
