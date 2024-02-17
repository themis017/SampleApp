//
//  Name.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public struct Name: RawRepresentable, Equatable, Codable {
        
    public var rawValue: String
    
    public static let nameRegex = "^[\\w\\.]+$"
    
    public init?(rawValue: String) {
        guard Name.validateName(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validateName(_ name: String) -> NameValueError? {
        guard name.isNotEmpty() else {
            return .emptyValue
        }
        
        guard !name.length(isLessThan: 2) else {
            return .shortValue
        }
        
        guard !name.length(isMoreThan: 20) else {
            return .longValue
        }
        
        guard name.matches(nameRegex) else {
            return .invalidFormat
        }
        
        return nil
    }
}
