//
//  UserProfileView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct UserProfileView: View {
    
    @ObservedObject
    private var viewModel: UserProfileViewModel
    
    public static let sceneIdentity = "UserProfileView"
    
    public init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            if let userProfile = viewModel.userProfile {
                
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
                    
                    Divider()
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.perform(.editProfile)
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .flexible()
        .background(Color.white)
    }
}

#if DEBUG

struct UserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfileView(viewModel: .previewViewModel())
    }
}

#endif
