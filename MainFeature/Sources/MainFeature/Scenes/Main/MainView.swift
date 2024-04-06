//
//  MainView.swift
//
//
//  Created by Themis Makedas on 15/1/24.
//

import Foundation
import SwiftUI
import UILayer
import HomeFeature
import SearchFeature
import FavouritesFeature
import UserProfileFeature

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
                SearchView(viewModel: viewModel.searchViewModel)
            case .upload:
                EmptyView()
            case .favourites:
                FavouritesView(viewModel: viewModel.favouritesViewModel)
            case .profile:
                UserProfileView(viewModel: viewModel.userProfileViewModel)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                TabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                    viewModel.perform(.selectedTab(selectedTab))
                }
            }
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
