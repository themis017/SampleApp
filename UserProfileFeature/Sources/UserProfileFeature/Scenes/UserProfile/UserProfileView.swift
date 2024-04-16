//
//  UserProfileView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import UILayer

public struct UserProfileView: View {
    
    @ObservedObject
    private var viewModel: UserProfileViewModel
    
    public static let sceneIdentity = "UserProfileView"
    
    let amountToPullBeforeRefreshing: CGFloat = 200
    
    public init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            
            if let userProfile = viewModel.userProfile {
                ScrollView {
                    
                    if viewModel.isCurrentlyRefreshing {
                        ProgressView()
                    }
                    
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
                        
                        profileOptions
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .overlay(GeometryReader { geo in
                        let currentScrollViewPosition = -geo.frame(in: .global).origin.y
                        
                        if currentScrollViewPosition < -amountToPullBeforeRefreshing && !viewModel.isCurrentlyRefreshing {
                            Color.clear.preference(key: ViewOffsetPreferenceKey.self, value: -geo.frame(in: .global).origin.y)
                        }
                    })
                }
                .background(Color(UIColor.systemGray6))
                .onPreferenceChange(ViewOffsetPreferenceKey.self) { scrollPosition in
                    if scrollPosition < -amountToPullBeforeRefreshing {
                            viewModel.perform(.refresh)
                    }
                }
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                viewModel.showingLogoutAlert = true
                            }
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .alert(isPresented: $viewModel.showingLogoutAlert) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .default(Text("Cancel")),
                        secondaryButton: .destructive(Text("Log Out"), action: {
                            viewModel.perform(.logout)
                        })
                    )
                }
            }
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            Divider()
                .background(Color.tabBarBackgroundColor)
        }
    }
    
    private var profileOptions: some View {
        VStack(spacing: 16) {
            Button {
                viewModel.perform(.editProfile)
            } label: {
                HStack {
                    Label("Edit Profile", systemImage: "pencil")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color.black)
            }
            
            Divider()
            
            Button {
                
            } label: {
                HStack {
                    Label("Notifications", systemImage: "bell")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color.black)
            }
            
            Divider()
            
            Button {
                
            } label: {
                HStack {
                    Label("Invite friends", systemImage: "person.2")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color.black)
            }
            
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 24)
    }
}

#if DEBUG

struct UserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfileView(viewModel: .previewViewModel())
    }
}

#endif
