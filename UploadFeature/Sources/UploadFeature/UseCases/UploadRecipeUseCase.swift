//
//  UploadRecipeUseCase.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import AVFoundation
import Photos
import ApplicationLayer
import UILayer

public protocol UploadRecipeUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    var uploadRecipeImageScene: Observable<UploadRecipeImageScene> { get }
       
    func showRecipeImage()
    func checkPhotoLibraryPermission()
    func checkCameraPermission()
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let uploadRecipeImageScene: Observable<UploadRecipeImageScene>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.uploadRouter = uploadRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.uploadRecipeImageScene = Observable(initialValue: .recipeImage)
        
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
    
    public func showRecipeImage() {
        uploadRecipeImageScene.value = .recipeImage
    }
    
    public func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized, .limited:
            uploadRecipeImageScene.value = .imagePicker
        case .notDetermined:
            requestPhotoLibraryPermission()
        case .denied, .restricted:
            uploadRecipeImageScene.value = .unauthorizedPhotoLibrary
        @unknown default:
            break
        }
    }
    
    private func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            switch authorizationStatus {
            case .authorized, .limited:
                self.uploadRecipeImageScene.value = .imagePicker
            case .notDetermined:
                self.requestPhotoLibraryPermission()
            case .denied, .restricted:
                self.uploadRecipeImageScene.value = .unauthorizedPhotoLibrary
            @unknown default:
                break
            }
        }
    }
    
    public func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            uploadRecipeImageScene.value = .imagePicker
        case .notDetermined:
            requestCameraPermission()
        case .denied, .restricted:
            uploadRecipeImageScene.value = .unauthorizedCamera
        @unknown default:
            break
        }
        
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                guard accessGranted else {
                    self.uploadRecipeImageScene.value = .unauthorizedCamera
                    return
                }
                
                self.uploadRecipeImageScene.value = .imagePicker
            }
        }
    }
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var uploadRecipeImageScene: Observable<UploadRecipeImageScene>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.uploadRecipeImageScene = Observable(initialValue: .recipeImage)
    }
    
    public func showRecipeImage() {}
    public func checkPhotoLibraryPermission() {}
    public func checkCameraPermission() {}
}

#endif
