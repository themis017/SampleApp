//
//  OtherUserProfileView.swift
//
//
//  Created by Themis Makedas on 12/2/24.
//

import Foundation
import SwiftUI
import UILayer

public struct OtherUserProfileView: View {
    
    @ObservedObject
    private var viewModel: OtherUserProfileViewModel
    
    public static let sceneIdentity = "OtherUserProfileView"
    
    public init(viewModel: OtherUserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        if let userProfile = viewModel.userProfile {
            NavigationView {
                
                VStack(spacing: 0) {
                    
                    ScrollView {
                        
                        VStack(spacing: 0) {
                            
                            HStack(spacing: 16) {
                                Image("user")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                VStack(spacing: 4) {
                                    Text(userProfile.name.rawValue)
                                        .font(.title)
                                    
                                    Text(userProfile.username.rawValue)
                                        .font(.title3)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            
                            if let isFollowing = userProfile.isFollowing {
                                Button {
                                    viewModel.perform(isFollowing ? .unfollow : .follow)
                                } label: {
                                    Text(isFollowing ? "Unfollow" : "Follow")
                                        .bold()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                                .foregroundColor(Color.white)
                                .background(isFollowing ? Color.gray : Color.blue)
                                .clipShape(
                                    Capsule()
                                )
                            }
                            
                            Text(userProfile.description.rawValue)
                                .font(.body)
                                .flexible(.horizontal, alignment: .leading)
                                .padding(.vertical, 16)
                            
                            Divider()
                            
                            HStack(spacing: 0) {
                                
                                VStack(spacing: 4) {
                                    Text(String(userProfile.recipesCount))
                                        .font(.body)
                                        .foregroundStyle(Color.blue)
                                    
                                    Text("Recipes")
                                        .font(.body)
                                        .foregroundStyle(Color.blue)
                                }
                                .flexible(.horizontal)
                                
                                VStack(spacing: 4) {
                                    Text(String(userProfile.followersCount))
                                        .font(.body)
                                        .foregroundStyle(Color.blue)
                                    
                                    Text("Followers")
                                        .font(.body)
                                        .foregroundStyle(Color.blue)
                                }
                                .flexible(.horizontal)
                            }
                            .padding(.top, 16)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .background(Color(UIColor.systemGray6))
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            viewModel.perform(.dismiss)
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    TabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                        viewModel.perform(.selectedTab(selectedTab))
                    }
                }
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom) {
                Divider()
                    .background(Color.tabBarBackgroundColor)
            }
        } else {
            NavigationView {
                EmptyView()
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                viewModel.perform(.dismiss)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    TabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                        viewModel.perform(.selectedTab(selectedTab))
                    }
                }
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom) {
                Divider()
                    .background(Color.tabBarBackgroundColor)
            }
        }
    }
}

#if DEBUG

struct OtherUserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        OtherUserProfileView(viewModel: .previewViewModel())
    }
}

#endif
