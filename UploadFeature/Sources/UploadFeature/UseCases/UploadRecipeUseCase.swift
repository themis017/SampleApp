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
    var isImagePickerPresented: Observable<Bool> { get }
    var isUnauthorizedPhotoLibraryPresented: Observable<Bool> { get }
    var isUnauthorizedCameraPresented: Observable<Bool> { get }
       
    func checkPhotoLibraryPermission()
    func checkCameraPermission()
}

public class UploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let isImagePickerPresented: Observable<Bool>
    public let isUnauthorizedPhotoLibraryPresented: Observable<Bool>
    public let isUnauthorizedCameraPresented: Observable<Bool>
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let uploadRouter: any UploadRouting
    
    public init(uploadRouter: any UploadRouting) {
        
        self.uploadRouter = uploadRouter
        self.userProfile = Observable(initialValue: AppData.shared.value(of: .userProfile))
        self.isImagePickerPresented = Observable(initialValue: false)
        self.isUnauthorizedPhotoLibraryPresented = Observable(initialValue: false)
        self.isUnauthorizedCameraPresented = Observable(initialValue: false)
        
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
            isImagePickerPresented.value = true
        case .notDetermined:
            requestPhotoLibraryPermission()
        case .denied, .restricted:
            isUnauthorizedPhotoLibraryPresented.value = true
        @unknown default:
            break
        }
    }
    
    private func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            switch authorizationStatus {
            case .authorized, .limited:
                self.isImagePickerPresented.value = true
            case .notDetermined:
                self.requestPhotoLibraryPermission()
            case .denied, .restricted:
                self.isUnauthorizedPhotoLibraryPresented.value = true
            @unknown default:
                break
            }
        }
    }
    
    public func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            isImagePickerPresented.value = true
        case .notDetermined:
            requestCameraPermission()
        case .denied, .restricted:
            isUnauthorizedCameraPresented.value = true
        @unknown default:
            break
        }
        
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                guard accessGranted else {
                    self.isUnauthorizedCameraPresented.value = true
                    return
                }
                
                self.isImagePickerPresented.value = true
            }
        }
    }
    
}

#if DEBUG

public class PreviewUploadRecipeUseCase: UploadRecipeUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var isImagePickerPresented: Observable<Bool>
    public var isUnauthorizedPhotoLibraryPresented: Observable<Bool>
    public var isUnauthorizedCameraPresented: Observable<Bool>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.isImagePickerPresented = Observable(initialValue: false)
        self.isUnauthorizedPhotoLibraryPresented = Observable(initialValue: false)
        self.isUnauthorizedCameraPresented = Observable(initialValue: false)
    }
    
    public func checkPhotoLibraryPermission() {}
    public func checkCameraPermission() {}
}

#endif
