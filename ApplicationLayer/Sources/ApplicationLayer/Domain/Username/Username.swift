//
//  Username.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public struct Username: RawRepresentable, Equatable {
        
    public var rawValue: String
    
    public static let usernameRegex = "^[\\w\\.]+$"
    
    public init?(rawValue: String) {
        guard Username.validateUsername(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validateUsername(_ username: String) -> UsernameValueError? {
        guard username.isNotEmpty() else {
            return .emptyValue
        }
        
        guard !username.length(isLessThan: 2) else {
            return .shortValue
        }
        
        guard !username.length(isMoreThan: 15) else {
            return .longValue
        }
        
        guard username.matches(usernameRegex) else {
            return .invalidFormat
        }
        
        return nil
    }
}
