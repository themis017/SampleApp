//
//  MainRouting.swift
//
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation

public protocol MainRouting: Routing {
    
    func showEntryPointScene()
    func showMainScene()
    func showMainScene(with selectedTab: TabBarCategory)
//    func showHomeScene()
//    func showUserProfileScene()
//    func showSettingsScene()
}
