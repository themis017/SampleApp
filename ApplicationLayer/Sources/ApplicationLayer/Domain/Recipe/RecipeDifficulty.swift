//
//  RecipeDifficulty.swift
//
//
//  Created by Themis Makedas on 5/2/24.
//

import Foundation

public enum RecipeDifficulty: Int, CustomStringConvertible {
    case veryEasy = 1, easy, medium, difficult, verydifficult
    
    public var description: String {
        switch self {
        case .veryEasy:
            return "Very easy"
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .difficult:
            return "Difficult"
        case .verydifficult:
            return "Very difficult"
        }
    }
}
