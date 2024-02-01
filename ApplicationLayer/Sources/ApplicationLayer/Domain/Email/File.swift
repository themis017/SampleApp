//
//  EmailValueError.swift
//  
//
//  Created by Themis Makedas on 1/2/24.
//

public enum EmailValueError: DomainError {
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
