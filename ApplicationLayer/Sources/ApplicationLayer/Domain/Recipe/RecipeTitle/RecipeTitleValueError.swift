//
//  RecipeTitleValueError.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation

public enum RecipeTitleValueError: DomainValueError {
    case emptyValue
    case shortValue
    case longValue
    case invalidFormat
    
    public var localizedErrorTitle: String {
        switch self {
        case .emptyValue:
            return "Recipe's title must not be empty"
        case .shortValue:
            return "Recipe's title is too short"
        case .longValue:
            return "Recipe's title is too long"
        case .invalidFormat:
            return "Invalid recipe's title format"
        }
    }
}
