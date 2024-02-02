//
//  NameValueError.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public enum NameValueError: DomainValueError {
    case emptyValue
    case shortValue
    case longValue
    case invalidFormat
    
    public var localizedErrorTitle: String {
        switch self {
        case .emptyValue:
            return "Name must not be empty"
        case .shortValue:
            return "Name is too short"
        case .longValue:
            return "Name is too long"
        case .invalidFormat:
            return "Invalid name format"
        }
    }
}
