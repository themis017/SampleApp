//
//  EditProfileUseCase.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol EditProfileUseCaseProviding {
    
    var userProfile: Observable<UserProfile?> { get }
    var email: Observable<String> { get }
    var isValidatingEmail: Observable<Bool> { get }
    var username: Observable<String> { get }
    var isValidatingUsername: Observable<Bool> { get }
    var name: Observable<String> { get }
    var description: Observable<String> { get }
    
    func dismiss()
    func showUpload()
    func showPath(for selectedTab: TabBarCategory)
    func save()
    func validateEmail()
    func validateUsername()
    func uplaodImage()
}

public class EditProfileUseCase: EditProfileUseCaseProviding {
    
    public let userProfile: Observable<UserProfile?>
    public let email: Observable<String>
    public let isValidatingEmail: Observable<Bool>
    public let username: Observable<String>
    public let isValidatingUsername: Observable<Bool>
    public let name: Observable<String>
    public let description: Observable<String>
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        let userProfile: UserProfile? = AppData.shared.value(of: .userProfile)
        
        self.userProfile = Observable(initialValue: userProfile)
        self.email = Observable(initialValue: userProfile?.email.rawValue ?? "")
        self.isValidatingEmail = Observable(initialValue: false)
        self.username = Observable(initialValue: userProfile?.username.rawValue ?? "")
        self.isValidatingUsername = Observable(initialValue: false)
        self.name = Observable(initialValue: userProfile?.name.rawValue ?? "")
        self.description = Observable(initialValue: userProfile?.description.rawValue ?? "")
        
        if userProfile == nil {
            loadUserProfile()
        }
    }
    
    private func loadUserProfile() {
        userProfile.value = UserProfile.principalUser
        email.value = userProfile.value?.email.rawValue ?? ""
        username.value = userProfile.value?.username.rawValue ?? ""
        name.value = userProfile.value?.name.rawValue ?? ""
        description.value = userProfile.value?.description.rawValue ?? ""
    }
    
    public func dismiss() {
        userProfileRouter.popScene(animated: true)
    }
    
    public func showUpload() {
        userProfileRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        if selectedTab == .profile {
            userProfileRouter.dismissToRoot(for: selectedTab)
        } else {
            let selectedTabEvent = SelectedTabEvent()
            selectedTabEvent.userInfo["tab"] = selectedTab
            EventPipeline.shared.send(selectedTabEvent)
            
            userProfileRouter.showPath(for: selectedTab)
        }
    }
    
    public func save() {
        print("TODO: Save edited profile")
    }
    
    @MainActor
    public func validateEmail() {
        guard email.value.isNotEmpty() else {
            return
        }
        
        isValidatingEmail.value = true
        
        // MARK: Peform validation request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isValidatingEmail.value = false
        }
    }
    
    @MainActor
    public func validateUsername() {
        guard username.value.isNotEmpty() else {
            return
        }
        
        isValidatingUsername.value = true
        
        // MARK: Peform validation request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isValidatingUsername.value = false
        }
    }
    
    public func uplaodImage() {
        
    }
}

#if DEBUG

public class PreviewEditProfileUseCase: EditProfileUseCaseProviding {
    
    public var userProfile: Observable<UserProfile?>
    public var email: Observable<String>
    public var isValidatingEmail: Observable<Bool>
    public var username: Observable<String>
    public var isValidatingUsername: Observable<Bool>
    public var name: Observable<String>
    public var description: Observable<String>
    
    public init() {
        self.userProfile = Observable(initialValue: UserProfile.principalUser)
        self.email = Observable(initialValue: userProfile.value?.email.rawValue ?? "")
        self.isValidatingEmail = Observable(initialValue: false)
        self.username = Observable(initialValue: userProfile.value?.username.rawValue ?? "")
        self.isValidatingUsername = Observable(initialValue: false)
        self.name = Observable(initialValue: userProfile.value?.name.rawValue ?? "")
        self.description = Observable(initialValue: userProfile.value?.description.rawValue ?? "")
    }
    
    public func dismiss() {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
    public func save() {}
    public func validateEmail() {}
    public func validateUsername() {}
    public func uplaodImage() {}
}

#endif
