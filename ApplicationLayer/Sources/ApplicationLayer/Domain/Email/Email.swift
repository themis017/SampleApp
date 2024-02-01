//
//  Email.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation

public struct Email: RawRepresentable, Equatable {
        
    public var rawValue: String
    
    public static let emailRegex = "^([\\w-\\.+]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([\\w-]+\\.)+))([a-zA-Z]{2,9}|[0-9]{1,10})(\\]?)$"
    
    public init?(rawValue: String) {
        guard Email.validateEmail(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validateEmail(_ email: String) -> EmailValueError? {
        guard email.isNotEmpty() else {
            return .emptyValue
        }
        
        guard email.matches(emailRegex) else {
            return .invalidFormat
        }
        
        return nil
    }
}
