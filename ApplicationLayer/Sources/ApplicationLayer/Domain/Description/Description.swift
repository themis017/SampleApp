//
//  Description.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation

public struct Description: RawRepresentable, Equatable, Codable {
        
    public var rawValue: String
        
    public init?(rawValue: String) {
        guard Description.validateDescription(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validateDescription(_ description: String) -> DescriptionValueError? {
        
        guard !description.length(isMoreThan: 300) else {
            return .longValue
        }
        
        return nil
    }
}
