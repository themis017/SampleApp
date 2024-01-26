//
//  UserProfile_A_View.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import SwiftUI

public struct UserProfile_A_View: View {
    
    @ObservedObject
    private var viewModel: UserProfile_A_ViewModel
    
    public static let sceneIdentity = "UserProfile_A_View"
    
    public init(viewModel: UserProfile_A_ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("UserProfile_A_View")
                .padding(16)
                .foregroundColor(.brown)
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
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            

        }
        .background(Color.green)
        .slideBack {
            viewModel.perform(.dismiss(animated: false))
        }
        .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
            viewModel.perform(.selectedTab(selectedTab))
        }
        .onAppear {
            viewModel.selectedTab = .profile
        }
    }
}

#if DEBUG

struct UserProfile_A_View_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfile_A_View(viewModel: .previewViewModel())
    }
}

#endif
