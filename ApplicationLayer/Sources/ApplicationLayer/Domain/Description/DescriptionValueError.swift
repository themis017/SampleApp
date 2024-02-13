//
//  DescriptionValueError.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation

public enum DescriptionValueError: DomainValueError {
    case longValue
    
    public var localizedErrorTitle: String {
        switch self {
        case .longValue:
            return "Description is too long"
        }
    }
}
