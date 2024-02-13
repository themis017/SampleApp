//
//  EditProfileViewModel.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class EditProfileViewModel: ViewModel {
    
    public enum Action {
        case selectedTab(TabBarCategory)
        case dismiss
        case save
        case uplaodImage
    }
    
    var selectedTab: TabBarCategory = .profile
    
    @Published
    var userProfile: UserProfile?
    
    @EmailValidated
    var email: String
    
    @Published
    var emailError: EmailValueError?
    
    @Published
    var isValidatingEmail: Bool = false
    
    @UsernameValidated
    var username: String
    
    @Published
    var usernameError: UsernameValueError?
    
    @Published
    var isValidatingUsername: Bool = false
    
    @NameValidated
    var name: String
    
    @Published
    var nameError: NameValueError?
    
    @DescriptionValidated
    var description: String
    
    @Published
    var descriptionError: DescriptionValueError?
    
    public var isSaveEnabled: Bool {
        emailError == nil &&
        usernameError == nil &&
        nameError == nil &&
        descriptionError == nil &&
        !isValidatingEmail &&
        !isValidatingUsername
    }
    
    private let editProfileUseCase: EditProfileUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(editProfileUseCase: EditProfileUseCaseProviding) {
        self.editProfileUseCase = editProfileUseCase
        
        let user = editProfileUseCase.userProfile.value
        self.userProfile = user
        
        self.email = user?.email.rawValue ?? ""
        self.username = user?.username.rawValue ?? ""
        self.name = user?.name.rawValue ?? ""
        self.description = user?.description.rawValue ?? ""
        
        bind(\.userProfile, to: editProfileUseCase.userProfile)
            .store(in: &subscriptions)
        
        forward(_email.emailPublisher, to: editProfileUseCase.email)
            .store(in: &subscriptions)
        
        forward(_username.usernamePublisher, to: editProfileUseCase.username)
            .store(in: &subscriptions)
        
        forward(_name.namePublisher, to: editProfileUseCase.name)
            .store(in: &subscriptions)
        
        forward(_description.descriptionPublisher, to: editProfileUseCase.description)
            .store(in: &subscriptions)
        
        $userProfile
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.userProfileUpdated(to: newValue)
            }
            .store(in: &subscriptions)
        
        _email.emailErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] emailValueError in
                self?.emailError = emailValueError
            }
            .store(in: &subscriptions)
        
        _username.usernameErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] usernameValueError in
                self?.usernameError = usernameValueError
            }
            .store(in: &subscriptions)
        
        _name.nameErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] nameValueError in
                self?.nameError = nameValueError
            }
            .store(in: &subscriptions)
        
        _description.descriptionErrorPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] descriptionValueError in
                self?.descriptionError = descriptionValueError
            }
            .store(in: &subscriptions)
        
        _email.emailPublisher
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.editProfileUseCase.validateEmail()
            }
            .store(in: &subscriptions)
        
        _username.usernamePublisher
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.editProfileUseCase.validateUsername()
            }
            .store(in: &subscriptions)
    }
    
    private func userProfileUpdated(to user: UserProfile) {
        email = user.email.rawValue
        username = user.username.rawValue
        name = user.name.rawValue
        description = user.description.rawValue
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .selectedTab(let tabCategory):
            guard tabCategory != .upload else {
                editProfileUseCase.showUpload()
                return
            }
            
            editProfileUseCase.showPath(for: tabCategory)
        case .dismiss:
            editProfileUseCase.dismiss()
        case .save:
            editProfileUseCase.save()
        case .uplaodImage:
            editProfileUseCase.uplaodImage()
        }
    }
}

#if DEBUG

public extension EditProfileViewModel {
    
    static func previewViewModel() -> EditProfileViewModel {
        let previewUseCase = PreviewEditProfileUseCase()
        return EditProfileViewModel(editProfileUseCase: previewUseCase)
    }
}

#endif
