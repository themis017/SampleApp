//
//  Email.swift
//  
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public struct Email: DomainRawValue, Equatable {
    
    public enum ValueError: DomainError {
        case emptyValue
        case invalidFormat
        
        public var localizedErrorTitle: String {
            LocalizedString("VALIDATION_ERROR.EMAIL.TITLE", bundle: .module).content
        }
        
        public var localized: String {
            switch self {
            case .emptyValue:
                return LocalizedString("VALIDATION_ERROR.EMAIL.INPUT_EMPTY", bundle: .module).content
            case .invalidFormat:
                return LocalizedString("VALIDATION_ERROR.EMAIL.INVALID_FORMAT", bundle: .module).content
            }
        }
    }
    
    public var rawValue: String
    
    public init(_ rawValue: String?) throws {
        let rawValue = try Validate.exists(rawValue, elseThrow: ValueError.emptyValue)
        try Validate.notEmpty(rawValue, elseThrow: ValueError.emptyValue)
        try Validate.value(rawValue, matches: .emailRegex, elseThrow: ValueError.invalidFormat)
        
        self.rawValue = rawValue
    }
}
