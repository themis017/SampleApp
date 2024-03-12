//
//  UploadRecipeUseCase.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import Combine
import AVFoundation
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
    
    func getCameraPermission() async {
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            break
//            isCameraPermission = true
        case .notDetermined:
            await AVCaptureDevice.requestAccess(for: .video)
//            isCameraPermission = true
        case .denied:
            break
//            isCameraPermission = false
        case .restricted:
            break
//            isCameraPermission = false
        @unknown default:
            break
//            isCameraPermission = false
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
