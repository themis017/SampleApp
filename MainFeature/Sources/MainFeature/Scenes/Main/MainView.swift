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
        
        VStack(spacing: 0) {
            switch viewModel.selectedTab {
            case .home:
                HomeView(viewModel: viewModel.homeViewModel)
            case .search:
                Text("Search")
            case .notifications:
                Text("Notifications")
            case .profile:
                UserProfileView(viewModel: viewModel.userProfileViewModel)
            }
        }
        .tabBar(selectedTab: $viewModel.selectedTab) { selectedTab in
            viewModel.perform(.selectedTab(selectedTab))
        }
        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("### MAIN")
                viewModel.perform(.refresh)
//            }
        }
    }
}

#if DEBUG

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(viewModel: .previewViewModel())
    }
}

#endif
