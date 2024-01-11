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
    
    private let key: String
    private let defaultValue: T
    
    private let subject: PassthroughSubject<T, Never>
    
    public var publisher: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self.subject = PassthroughSubject()
    }

    public var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
            subject.send(newValue)
        }
    }
}
