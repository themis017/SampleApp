//
//  UserProfile.swift
//  
//
//  Created by Themis Makedas on 9/2/24.
//

import Foundation
import SwiftUI

public struct UserProfile: Identifiable, Equatable, Codable {
    
    public var id: String
    public var profileImage: String
    public var backgroundImage: String
    public var email: Email
    public var username: Username
    public var name: Name
    public var description: Description
    public var recipesCount: UInt
    public var followersCount: UInt
    public var isFollowing: Bool?
    
    public func changingIsFollowing(to newValue: Bool) -> UserProfile {
        var mutableSelf = self
        mutableSelf.isFollowing = newValue
        return mutableSelf
    }
    
    public func changingFollowersCount(to newValue: UInt) -> UserProfile {
        var mutableSelf = self
        mutableSelf.followersCount = newValue
        return mutableSelf
    }
    
    public static var popularUsers: [UserProfile] {
        [user_1, user_2, user_3, user_4, user_5, user_6, user_7, user_8, user_9, user_10]
    }
    
    public static var principalUser: UserProfile {
        UserProfile(id: "0",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "prncipal_user@gmail.com")!,
                    username: Username(rawValue: "principal_username")!,
                    name: Name(rawValue: "principal_name")!,
                    description: Description(rawValue: "principal_description")!,
                    recipesCount: 400,
                    followersCount: 1000,
                    isFollowing: nil)
    }
    
    public static var user_1: UserProfile {
        UserProfile(id: "1",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_1@gmail.com")!,
                    username: Username(rawValue: "username_1")!,
                    name: Name(rawValue: "name_1")!,
                    description: Description(rawValue: "Description_1")!,
                    recipesCount: 100,
                    followersCount: 20,
                    isFollowing: true)
    }
    
    public static var user_2: UserProfile {
        UserProfile(id: "2",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_2@gmail.com")!,
                    username: Username(rawValue: "username_2")!,
                    name: Name(rawValue: "name_2")!,
                    description: Description(rawValue: "Description_2")!,
                    recipesCount: 50,
                    followersCount: 120,
                    isFollowing: false)
    }
    
    public static var user_3: UserProfile {
        UserProfile(id: "3",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_3@gmail.com")!,
                    username: Username(rawValue: "username_3")!,
                    name: Name(rawValue: "name_3")!,
                    description: Description(rawValue: "Description_3")!,
                    recipesCount: 200,
                    followersCount: 240,
                    isFollowing: true)
    }
    
    public static var user_4: UserProfile {
        UserProfile(id: "4",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_4@gmail.com")!,
                    username: Username(rawValue: "username_4")!,
                    name: Name(rawValue: "name_4")!,
                    description: Description(rawValue: "Description_4")!,
                    recipesCount: 180,
                    followersCount: 300,
                    isFollowing: false)
    }
    
    public static var user_5: UserProfile {
        UserProfile(id: "5",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_5@gmail.com")!,
                    username: Username(rawValue: "username_5")!,
                    name: Name(rawValue: "name_5")!,
                    description: Description(rawValue: "Description_5")!,
                    recipesCount: 270,
                    followersCount: 190,
                    isFollowing: false)
    }
    
    public static var user_6: UserProfile {
        UserProfile(id: "6",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_6@gmail.com")!,
                    username: Username(rawValue: "username_6")!,
                    name: Name(rawValue: "name_6")!,
                    description: Description(rawValue: "Description_6")!,
                    recipesCount: 17,
                    followersCount: 10,
                    isFollowing: false)
    }
    
    public static var user_7: UserProfile {
        UserProfile(id: "7",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_7@gmail.com")!,
                    username: Username(rawValue: "username_7")!,
                    name: Name(rawValue: "name_7")!,
                    description: Description(rawValue: "Description_7")!,
                    recipesCount: 27,
                    followersCount: 19,
                    isFollowing: true)
    }
    
    public static var user_8: UserProfile {
        UserProfile(id: "8",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_8@gmail.com")!,
                    username: Username(rawValue: "username_8")!,
                    name: Name(rawValue: "name_8")!,
                    description: Description(rawValue: "Description_8")!,
                    recipesCount: 15,
                    followersCount: 25,
                    isFollowing: true)
    }
    
    public static var user_9: UserProfile {
        UserProfile(id: "9",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_9@gmail.com")!,
                    username: Username(rawValue: "username_9")!,
                    name: Name(rawValue: "name_9")!,
                    description: Description(rawValue: "Description_9")!,
                    recipesCount: 10,
                    followersCount: 20,
                    isFollowing: false)
    }
    
    public static var user_10: UserProfile {
        UserProfile(id: "10",
                    profileImage: "",
                    backgroundImage: "",
                    email: Email(rawValue: "user_10@gmail.com")!,
                    username: Username(rawValue: "username_10")!,
                    name: Name(rawValue: "name_10")!,
                    description: Description(rawValue: "Description_10")!,
                    recipesCount: 30,
                    followersCount: 32,
                    isFollowing: true)
    }
}
