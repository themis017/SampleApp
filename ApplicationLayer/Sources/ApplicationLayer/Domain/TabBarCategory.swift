//
//  TabBarCategory.swift
//
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation

public enum TabBarCategory: CaseIterable, Codable {
    case home
    case search
    case upload
    case favourites
    case profile
    
    public var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .upload:
            return "Upload"
        case .favourites:
            return "Favourites"
        case .profile:
            return "Profile"
        }
    }
    
    public var iconTitle: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .upload:
            return "fork.knife.circle.fill"
        case .favourites:
            return "star"
        case .profile:
            return "person"
        }
    }
}
