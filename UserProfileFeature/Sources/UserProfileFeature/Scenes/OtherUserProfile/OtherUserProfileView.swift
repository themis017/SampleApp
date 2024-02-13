//
//  OtherUserProfileView.swift
//
//
//  Created by Themis Makedas on 12/2/24.
//

import Foundation
import SwiftUI

public struct OtherUserProfileView: View {
    
    @ObservedObject
    private var viewModel: OtherUserProfileViewModel
    
    public static let sceneIdentity = "OtherUserProfileView"
    
    public init(viewModel: OtherUserProfileViewModel) {
        self.viewModel = viewModel
        
        //        let appearance = UINavigationBarAppearance()
        //        appearance.configureWithOpaqueBackground()
        //        appearance.backgroundColor = UIColor.systemGray6
        //
        //        UINavigationBar.appearance().standardAppearance = appearance
        //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        
        NavigationView {
            if let userProfile = viewModel.userProfile {
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
                        
                        Text(userProfile.description)
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
                    //                        .background(Color(UIColor.green))
                }
                .background(Color(UIColor.systemGray6))
            }
        }
        .padding(.horizontal, 16)
    }
}

#if DEBUG

struct OtherUserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        OtherUserProfileView(viewModel: .previewViewModel())
    }
}

#endif
