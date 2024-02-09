//
//  UserProfile.swift
//  
//
//  Created by Themis Makedas on 9/2/24.
//

import Foundation
import SwiftUI

public struct UserProfile: Identifiable, Equatable {
    
    public var id: String
    public var profileImage: String
    public var backgroundImage: String
    public var username: Username
    public var name: Name
    public var description: String
    public var recipesCount: Int
    public var followersCount: Int
    
    public static var user_1: UserProfile =
        UserProfile(id: "1",
                    profileImage: "",
                    backgroundImage: "",
                    username: Username(rawValue: "username_1")!,
                    name: Name(rawValue: "name_1")!,
                    description: "Description_1",
                    recipesCount: 100,
                    followersCount: 20)
    
    public static var user_2: UserProfile =
        UserProfile(id: "2",
                    profileImage: "",
                    backgroundImage: "",
                    username: Username(rawValue: "username_2")!,
                    name: Name(rawValue: "name_2")!,
                    description: "Description_2",
                    recipesCount: 50,
                    followersCount: 120)
    
    public static var user_3: UserProfile =
        UserProfile(id: "3",
                    profileImage: "",
                    backgroundImage: "",
                    username: Username(rawValue: "username_3")!,
                    name: Name(rawValue: "name_3")!,
                    description: "Description_3",
                    recipesCount: 200,
                    followersCount: 240)
    
    public static var user_4: UserProfile =
        UserProfile(id: "4",
                    profileImage: "",
                    backgroundImage: "",
                    username: Username(rawValue: "username_4")!,
                    name: Name(rawValue: "name_4")!,
                    description: "Description_4",
                    recipesCount: 180,
                    followersCount: 300)
    
    public static var user_5: UserProfile =
        UserProfile(id: "5",
                    profileImage: "",
                    backgroundImage: "",
                    username: Username(rawValue: "username_5")!,
                    name: Name(rawValue: "name_5")!,
                    description: "Description_5",
                    recipesCount: 270,
                    followersCount: 190)

}
