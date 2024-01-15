//
//  MainView.swift
//
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import SwiftUI
import HomeFeature
import UserProfileFeature
import SettingsFeature

public struct MainView: View {
    
    @ObservedObject
    private var viewModel: MainViewModel
    
    public static let sceneIdentity = "MainView"
    
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        TabView {
            HomeView(viewModel: viewModel.homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            UserProfileView(viewModel: viewModel.userProfileViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
            
            SettingsView(viewModel: viewModel.settingsViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .toolbarBackground(.indigo, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}

#if DEBUG

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(viewModel: .previewViewModel())
    }
}

#endif
