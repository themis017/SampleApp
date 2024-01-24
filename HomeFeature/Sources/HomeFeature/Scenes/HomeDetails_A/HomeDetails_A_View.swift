//
//  HomeDetails_A_View.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import SwiftUI

public struct HomeDetails_A_View: View {
    
    @ObservedObject
    private var viewModel: HomeDetails_A_ViewModel
    
    public static let sceneIdentity = "HomeDetails_A_View"
    
    public init(viewModel: HomeDetails_A_ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("HomeDetails_A_View")
                .padding(16)
                .foregroundColor(.brown)
                .background(Color.white)
            
            Spacer()
            
            Button {
                viewModel.perform(.dismiss)
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
        .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
            viewModel.perform(.selectedTab(selectedTab))
        }
        .onAppear {
            viewModel.selectedTab = .home
        }
    }
}

#if DEBUG

struct HomeDetails_A_View_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeDetails_A_View(viewModel: .previewViewModel())
    }
}

#endif
