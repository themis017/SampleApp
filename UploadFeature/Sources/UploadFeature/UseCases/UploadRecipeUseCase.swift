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
       
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.uploadRouter = uploadRouter
        
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
    
    private func checkPhotoLibraryPermission() {
        
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        var isPhotoLibraryAuthorized = status == .authorized
        
        switch status {
        case .authorized:
            break
        case .notDetermined:
            requestPhotoLibraryPermission()
//            isPhotoLibraryAuthorized = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        case .denied:
            break
        case .restricted:
            break
        case .limited:
            break
        @unknown default:
            break
        }
        
    }
    
    private func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            
        }
    }
    
    private func checkCameraPermission() async {
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        var isCameraAuthorized = status == .authorized
        
        switch status {
        case .authorized:
            break
        case .notDetermined:
            requestCameraPermission()
        case .denied:
            break
        case .restricted:
            break
        @unknown default:
            break
        }
        
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
//                self.permissionGranted = accessGranted
            }
        }
    }
    
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
    }
    
}

#endif
