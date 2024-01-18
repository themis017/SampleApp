//
//  TabBarCategory.swift
//
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation

public enum TabBarCategory: CaseIterable {
    case home
    case search
    case profile
    case settings
    
    public var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    public var iconTitle: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .profile:
            return "person"
        case .settings:
            return "gearshape"
        }
    }
}
