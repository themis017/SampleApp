//
//  UploadRecipeUseCase.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation
import Photos
import ApplicationLayer
import UILayer

public protocol UploadRecipeUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    var uploadRecipeImageScene: Observable<UploadRecipeImageScene> { get }
    var selectedImage: Observable<UIImage?> { get }
    var recipeTitle: Observable<String> { get }
    var description: Observable<String> { get }
    var selectedHourIndex: Observable<Int> { get }
    var selectedMinuteIndex: Observable<Int> { get }
    var recipeDifficulty: Observable<RecipeDifficulty> { get }
    var ingredients: Observable<String> { get }
    var method: Observable<String> { get }
       
    func showRecipeImage()
    func checkPhotoLibraryPermission()
    func checkCameraPermission()
    func dismiss()
    func upload()
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let selectedImage: Observable<UIImage?>
    public let uploadRecipeImageScene: Observable<UploadRecipeImageScene>
    public let recipeTitle: Observable<String>
    public let description: Observable<String>
    public let selectedHourIndex: Observable<Int>
    public let selectedMinuteIndex: Observable<Int>
    public let recipeDifficulty: Observable<RecipeDifficulty>
    public let ingredients: Observable<String>
    public let method: Observable<String>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.uploadRouter = uploadRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.selectedImage = Observable(initialValue: nil)
        self.uploadRecipeImageScene = Observable(initialValue: .recipeImage)
        self.recipeTitle = Observable(initialValue: "")
        self.description = Observable(initialValue: "")
        self.selectedHourIndex = Observable(initialValue: 0)
        self.selectedMinuteIndex = Observable(initialValue: 0)
        self.recipeDifficulty = Observable(initialValue: .veryEasy)
        self.ingredients = Observable(initialValue: "")
        self.method = Observable(initialValue: "")
        
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
    
    public func dismiss() {
        uploadRouter.dismissSheet(animated: true)
    }
    
    public func upload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uploadRouter.dismissSheet(animated: true)
        }
    }
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {

    public var userProfile: Observable<UserProfile?>
    public var selectedImage: Observable<UIImage?>
    public var uploadRecipeImageScene: Observable<UploadRecipeImageScene>
    public var recipeTitle: Observable<String>
    public var description: Observable<String>
    public var selectedHourIndex: Observable<Int>
    public var selectedMinuteIndex: Observable<Int>
    public var recipeDifficulty: Observable<RecipeDifficulty>
    public var ingredients: Observable<String>
    public var method: Observable<String>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.selectedImage = Observable(initialValue: nil)
        self.uploadRecipeImageScene = Observable(initialValue: .recipeImage)
        self.recipeTitle = Observable(initialValue: "Recipe Title")
        self.description = Observable(initialValue: "Description")
        self.selectedHourIndex = Observable(initialValue: 1)
        self.selectedMinuteIndex = Observable(initialValue: 30)
        self.recipeDifficulty = Observable(initialValue: .medium)
        self.ingredients = Observable(initialValue: "Ingredients")
        self.method = Observable(initialValue: "Ingredients")
    }
    
    public func showRecipeImage() {}
    public func checkPhotoLibraryPermission() {}
    public func checkCameraPermission() {}
    public func dismiss() {}
    public func upload() {}
}

#endif
