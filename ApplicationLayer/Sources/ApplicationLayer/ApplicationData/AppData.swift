//
//  AppData.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation
import Combine

public struct AppData {
    
    public enum StorageType: String {
        case username
        case enableAutoLogin
        
        var key: String {
            "\(self.rawValue)_key"
        }
    }
    
    public static let shared = AppData()
    
    // MARK: username
    @Storage(storageType: .username, defaultValue: "")
    public static var username: String
    
    private let usernameSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    
    public var usernamePublisher: AnyPublisher<String, Never> {
        usernameSubject.eraseToAnyPublisher()
    }

    // MARK: enableAutoLogin
    @Storage(storageType: .enableAutoLogin, defaultValue: false)
    public static var enableAutoLogin: Bool
    
    private let enableAutoLoginSubject: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    public var enableAutoLoginPublisher: AnyPublisher<Bool, Never> {
        enableAutoLoginSubject.eraseToAnyPublisher()
    }
    
    // Declare a User object
//    @Storage(key: "user_key", defaultValue: User(firstName: "", lastName: "", lastLogin: nil))
//    static var user: User
    
    public func value<T: Codable>(of storageType: AppData.StorageType) -> T? {
        switch storageType {
        case .username:
            return AppData.username as? T
        case .enableAutoLogin:
            return AppData.enableAutoLogin as? T
        }
    }
    
    public func save<T: Codable>(_ value: T, to storageType: AppData.StorageType) {
        switch storageType {
        case .username:
            guard let value = value as? String else {
                return
            }
            
            AppData.username = value
            usernameSubject.send(value)
        case .enableAutoLogin:
            guard let value = value as? Bool else {
                return
            }
            
            AppData.enableAutoLogin = value
            enableAutoLoginSubject.send(value)
        }
    }
}
