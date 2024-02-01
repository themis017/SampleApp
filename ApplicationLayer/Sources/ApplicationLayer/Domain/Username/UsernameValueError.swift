//
//  UsernameValueError.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public enum UsernameValueError: LocalizedError {
    case emptyValue
    case shortValue
    case longValue
    case invalidFormat
    
    public var errorDescription: String {
        switch self {
        case .emptyValue:
            return "Username must not be empty"
        case .shortValue:
            return "Username is too short"
        case .longValue:
            return "Username is too long"
        case .invalidFormat:
            return "Invalid username format"
        }
    }
}
