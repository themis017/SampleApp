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
        case enableAutoLogin
        case userProfile
        case favourites
        
        var key: String {
            "\(self.rawValue)_key"
        }
    }
    
    public static let shared = AppData()
    
    // MARK: enableAutoLogin
    @UserDefaultsStorage(storageType: .enableAutoLogin, defaultValue: false)
    public static var enableAutoLogin: Bool?
    
    private let enableAutoLoginSubject: PassthroughSubject<Bool?, Never> = PassthroughSubject()
    
    public var enableAutoLoginPublisher: AnyPublisher<Bool?, Never> {
        enableAutoLoginSubject.eraseToAnyPublisher()
    }
    
    // MARK: userProfile
    @JSONStorage(fileName: Self.StorageType.userProfile.key, defaultValue: nil)
    public static var userProfile: UserProfile?
    
    private let userProfileSubject: PassthroughSubject<UserProfile?, Never> = PassthroughSubject()
    
    public var userProfilePublisher: AnyPublisher<UserProfile?, Never> {
        userProfileSubject.eraseToAnyPublisher()
    }
    
    // MARK: favourites
    @JSONStorage(fileName: Self.StorageType.favourites.key, defaultValue: nil)
    public static var favourites: [Recipe]?
    
    private let favouritesSubject: PassthroughSubject<[Recipe]?, Never> = PassthroughSubject()
    
    public var favouritesPublisher: AnyPublisher<[Recipe]?, Never> {
        favouritesSubject.eraseToAnyPublisher()
    }
    
    public func value<T: Codable>(of storageType: AppData.StorageType) -> T? {
        switch storageType {
        case .enableAutoLogin:
            return AppData.enableAutoLogin as? T
        case .userProfile:
            return AppData.userProfile as? T
        case .favourites:
            return AppData.favourites as? T
        }
    }
    
    public func save<T: Codable>(_ value: T, to storageType: AppData.StorageType) {
        switch storageType {
        case .enableAutoLogin:
            guard let value = value as? Bool else {
                return
            }
            
            AppData.enableAutoLogin = value
            enableAutoLoginSubject.send(value)
        case .userProfile:
            guard let value = value as? UserProfile else {
                return
            }
            
            AppData.userProfile = value
            userProfileSubject.send(value)
        case .favourites:
            guard let value = value as? [Recipe] else {
                return
            }
            
            AppData.favourites = value
            favouritesSubject.send(value)
        }
    }
}
