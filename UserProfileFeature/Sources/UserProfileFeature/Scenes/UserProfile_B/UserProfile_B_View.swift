//
//  UserProfile_B_View.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import SwiftUI

public struct UserProfile_B_View: View {
    
    @ObservedObject
    private var viewModel: UserProfile_B_ViewModel
    
    public static let sceneIdentity = "UserProfile_B_View"
    
    public init(viewModel: UserProfile_B_ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("UserProfile_B_View")
                .padding(16)
                .foregroundColor(.blue)
                .background(Color.white)
            
            Spacer()
            
            Button {
                viewModel.perform(.dismiss(animated: true))
            } label: {
                Text("Back")
                    .padding(24)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Button {
                viewModel.perform(.nextAction)
            } label: {
                Text("Next")
                    .padding(24)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            

        }
        .background(Color.blue)
        .slideBack {
            viewModel.perform(.dismiss(animated: false))
        }
        .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
            viewModel.perform(.selectedTab(selectedTab))
        }
//        .onAppear {
//            viewModel.selectedTab = .profile
//        }
    }
}

#if DEBUG

struct UserProfile_B_View_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfile_B_View(viewModel: .previewViewModel())
    }
}

#endif