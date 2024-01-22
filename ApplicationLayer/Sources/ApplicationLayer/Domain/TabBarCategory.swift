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
    case notifications
    case profile
    
    public var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .notifications:
            return "Notifications"
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
        case .notifications:
            return "bell"
        case .profile:
            return "person"
        }
    }
}
