//
//  OtherUserProfileUseCase.swift
//  
//
//  Created by Themis Makedas on 9/2/24.
//

import Foundation
import ApplicationLayer
import UILayer

public protocol OtherUserProfileUseCaseProviding {
    
    var selectedTab: Observable<TabBarCategory> { get }
    var userProfile: Observable<UserProfile?> { get }
    
    func dismiss()
    func showUpload()
    func showPath(for selectedTab: TabBarCategory)
    func follow()
    func unfollow()
}

public class OtherUserProfileUseCase: OtherUserProfileUseCaseProviding {
    
    public let selectedTab: Observable<TabBarCategory>
    public let userProfile: Observable<UserProfile?>
    
    private let userProfileRouter: any UserProfileRouting
    
    public init(selectedTab: TabBarCategory,
                user: UserReference,
                userProfileRouter: any UserProfileRouting) {
        
        self.userProfileRouter = userProfileRouter
        self.selectedTab = Observable(initialValue: selectedTab)
        self.userProfile = Observable(initialValue: nil)
        
        loadUserProfile(of: user)
    }
    
    private func loadUserProfile(of user: UserReference) {
        if user.id == "1" {
            userProfile.value = UserProfile.user_1
        } else if user.id == "2" {
            userProfile.value = UserProfile.user_2
        } else if user.id == "3" {
            userProfile.value = UserProfile.user_3
        } else if user.id == "4" {
            userProfile.value = UserProfile.user_4
        } else {
            userProfile.value = UserProfile.user_5
        }
    }
    
    public func dismiss() {
        userProfileRouter.popScene(animated: true)
    }
    
    public func showUpload() {
        userProfileRouter.showUploadScene()
    }
    
    public func showPath(for selectedTab: TabBarCategory) {
        if self.selectedTab.value == selectedTab {
            userProfileRouter.dismissToRoot(for: selectedTab)
        } else {
            let selectedTabEvent = SelectedTabEvent()
            selectedTabEvent.userInfo["tab"] = selectedTab
            EventPipeline.shared.send(selectedTabEvent)
            
            userProfileRouter.showPath(for: selectedTab)
        }
    }
    
    public func follow() {
        userProfile.value = userProfile.value?
            .changingIsFollowing(to: true)
            .changingFollowersCount(to: (userProfile.value?.followersCount ?? 0) + 1)
    }
    
    public func unfollow() {
        userProfile.value = userProfile.value?
            .changingIsFollowing(to: false)
            .changingFollowersCount(to: (userProfile.value?.followersCount ?? 0) - 1)
    }
}

#if DEBUG

public class PreviewOtherUserProfileUseCase: OtherUserProfileUseCaseProviding {
    
    public var selectedTab: Observable<TabBarCategory>
    public var userProfile: Observable<UserProfile?>
    
    public init() {
        self.selectedTab = .init(initialValue: .profile)
        self.userProfile = Observable(initialValue: UserProfile.user_1)
    }
    
    public func dismiss() {}
    public func showUpload() {}
    public func showPath(for selectedTab: TabBarCategory) {}
    public func follow() {}
    public func unfollow() {}
}

#endif
