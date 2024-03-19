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
        case showUploadRecipeName
    }
    
    @Published
    var userProfile: UserProfile?
    
    @Published
    var selectedImage: UIImage?
    
    @Published
    var isImagePickerPresented: Bool = false
    
    @Published
    var isConfirmationDialogPresented: Bool = false
    
    var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Published
    var isPhotoLibraryAuthorized: Bool
                                    
    @Published
    var isCameraAuthorized: Bool
    
    @Published
    var showUploadRecipeName: Bool = false
    
    private let uploadRecipeUseCase: UploadRecipeUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(uploadRecipeUseCase: UploadRecipeUseCaseProviding) {
        self.uploadRecipeUseCase = uploadRecipeUseCase
        
        self.userProfile = uploadRecipeUseCase.userProfile.value
        self.isPhotoLibraryAuthorized = uploadRecipeUseCase.isPhotoLibraryAuthorized.value
        self.isCameraAuthorized = uploadRecipeUseCase.isCameraAuthorized.value
        
        bind(\.userProfile, to: uploadRecipeUseCase.userProfile)
            .store(in: &subscriptions)
        
        bind(\.isPhotoLibraryAuthorized, to: uploadRecipeUseCase.isPhotoLibraryAuthorized)
            .store(in: &subscriptions)
        
        bind(\.isCameraAuthorized, to: uploadRecipeUseCase.isCameraAuthorized)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedPhotoLibrary:
            pickerSourceType = .photoLibrary
            isConfirmationDialogPresented = false
            uploadRecipeUseCase.checkPhotoLibraryPermission()
            isImagePickerPresented = true
        case .selectedCamera:
            pickerSourceType = .camera
            isConfirmationDialogPresented = false
            uploadRecipeUseCase.checkCameraPermission()
            isImagePickerPresented = true
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
