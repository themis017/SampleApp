//
//  Routing.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol Routing {
    
    func popScene()
    func dismissToRoot(for selectedTab: TabBarCategory)
    func showPath(for selectedTab: TabBarCategory)
}
