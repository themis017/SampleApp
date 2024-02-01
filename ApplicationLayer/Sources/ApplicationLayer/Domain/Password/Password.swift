//
//  Password.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public struct Password: RawRepresentable, Equatable {
        
    public var rawValue: String
    
    public static let passwordRegex = "^[\\w\\.]+$"
    
    public init?(rawValue: String) {
        guard Password.validatePassword(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validatePassword(_ password: String) -> PasswordValueError? {
        guard password.isNotEmpty() else {
            return .emptyValue
        }
        
        guard !password.length(isLessThan: 8) else {
            return .shortValue
        }
        
        guard !password.length(isMoreThan: 20) else {
            return .longValue
        }
        
        guard password.matches(passwordRegex) else {
            return .invalidFormat
        }
        
        return nil
    }
}
