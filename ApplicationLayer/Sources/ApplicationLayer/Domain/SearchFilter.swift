//
//  SearchFilter.swift
//
//
//  Created by Themis Makedas on 4/3/24.
//

import Foundation

public enum SearchFilter: CaseIterable, Codable {
    case recipes
    case users
    
    public var title: String {
        switch self {
        case .recipes:
            return "Recipes"
        case .users:
            return "Users"
        }
    }
    
    public var iconTitle: String {
        switch self {
        case .recipes:
            return "fork.knife.circle"
        case .users:
            return "person.circle"
        }
    }
}
