//
//  EmailValueError.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public enum EmailValueError: LocalizedError {
    case emptyValue
    case invalidFormat
    
    public var errorDescription: String {
        switch self {
        case .emptyValue:
            return "Email must not be empty"
        case .invalidFormat:
            return "Invalid email format"
        }
    }
}
