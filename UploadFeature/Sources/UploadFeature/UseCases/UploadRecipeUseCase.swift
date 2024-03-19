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
    var isPhotoLibraryAuthorized: Observable<Bool> { get }
    var isCameraAuthorized: Observable<Bool> { get }
       
    func checkPhotoLibraryPermission()
    func checkCameraPermission()
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let isPhotoLibraryAuthorized: Observable<Bool>
    public let isCameraAuthorized: Observable<Bool>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.uploadRouter = uploadRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.isPhotoLibraryAuthorized = Observable(initialValue: false)
        self.isCameraAuthorized = Observable(initialValue: false)
        
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
    
    public func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized, .limited:
            isPhotoLibraryAuthorized.value = true
        case .notDetermined:
            requestPhotoLibraryPermission()
        case .denied, .restricted:
            isPhotoLibraryAuthorized.value = false
        @unknown default:
            break
        }
    }
    
    private func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            switch authorizationStatus {
            case .authorized, .limited:
                self.isPhotoLibraryAuthorized.value = true
            case .notDetermined:
                self.requestPhotoLibraryPermission()
            case .denied, .restricted:
                self.isPhotoLibraryAuthorized.value = false
            @unknown default:
                break
            }
        }
    }
    
    public func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            isCameraAuthorized.value = true
        case .notDetermined:
            requestCameraPermission()
        case .denied, .restricted:
            isCameraAuthorized.value = false
        @unknown default:
            break
        }
        
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                self.isCameraAuthorized.value = accessGranted
            }
        }
    }
    
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var isPhotoLibraryAuthorized: Observable<Bool>
    public var isCameraAuthorized: Observable<Bool>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.isPhotoLibraryAuthorized = Observable(initialValue: true)
        self.isCameraAuthorized = Observable(initialValue: true)
    }
    
    public func checkPhotoLibraryPermission() {}
    public func checkCameraPermission() {}
}

#endif
