//
//  AppData.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation

public struct AppData {
    
    public static let shared = AppData()
    
    @Storage(key: "username_key", defaultValue: "")
    public static var username: String

    @Storage(key: "enable_auto_login_key", defaultValue: false)
    public static var enableAutoLogin: Bool
    
    // Declare a User object
//    @Storage(key: "user_key", defaultValue: User(firstName: "", lastName: "", lastLogin: nil))
//    static var user: User
}
