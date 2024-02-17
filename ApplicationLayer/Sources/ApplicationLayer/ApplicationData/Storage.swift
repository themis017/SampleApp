//
//  Storage.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation
import Combine

@propertyWrapper
public struct Storage<T: Codable> {
    
    private let storageType: AppData.StorageType
    private let defaultValue: T?

    init(storageType: AppData.StorageType, defaultValue: T?) {
        self.storageType = storageType
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.object(forKey: storageType.key) as? Data else {
                return nil
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: storageType.key)
        }
    }
}
