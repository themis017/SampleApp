//
//  RecipeTitle.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation

public struct RecipeTitle: RawRepresentable, Equatable, Codable {
        
    public var rawValue: String
    
    public static let recipeTitleRegex = "^[\\w\\.]+$"
    
    public init?(rawValue: String) {
        guard RecipeTitle.validateRecipeTitle(rawValue) != nil else {
            self.rawValue = rawValue
            return
        }
        
        return nil
    }
    
    static func validateRecipeTitle(_ recipeTitle: String) -> RecipeTitleValueError? {
        guard recipeTitle.isNotEmpty() else {
            return .emptyValue
        }
        
        guard !recipeTitle.length(isLessThan: 3) else {
            return .shortValue
        }
        
        guard !recipeTitle.length(isMoreThan: 20) else {
            return .longValue
        }
        
        guard recipeTitle.matches(recipeTitleRegex) else {
            return .invalidFormat
        }
        
        return nil
    }
}
