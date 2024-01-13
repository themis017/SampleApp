//
//  AppData.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation

public struct AppData {
    
    enum StorageType: String {
        case username
        case enableAutoLogin
        
        var key: String {
            "\(self.rawValue)_key"
        }
    }
    
    public static let shared = AppData()
    
    @Storage(storageType: .username, defaultValue: "")
    public static var username: String

    @Storage(storageType: .enableAutoLogin, defaultValue: false)
    public static var enableAutoLogin: Bool
    
    // Declare a User object
//    @Storage(key: "user_key", defaultValue: User(firstName: "", lastName: "", lastLogin: nil))
//    static var user: User
    
}
