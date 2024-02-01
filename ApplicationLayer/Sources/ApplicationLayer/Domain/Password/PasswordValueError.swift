//
//  PasswordValueError.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public enum PasswordValueError: LocalizedError {
    case emptyValue
    case shortValue
    case longValue
    case invalidFormat
    case passwordNotMatch
    
    public var errorDescription: String {
        switch self {
        case .emptyValue:
            return "Password must not be empty"
        case .shortValue:
            return "Password is too short"
        case .longValue:
            return "Password is too long"
        case .invalidFormat:
            return "Invalid password format"
        case .passwordNotMatch:
            return "Passwords not match"
        }
    }
}
