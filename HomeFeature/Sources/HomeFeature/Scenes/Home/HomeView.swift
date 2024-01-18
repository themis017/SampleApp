//
//  HomeView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct HomeView: View {
    
    @ObservedObject
    private var viewModel: HomeViewModel
    
    public static let sceneIdentity = "HomeView"
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("HomeView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.yellow)
            
            Spacer()
            
            Button {
                viewModel.perform(.nextAction)
            } label: {
                Text("Next")
                    .padding(24)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            

        }
        .background(Color.green)
        .tabBar(selectedTab: $viewModel.selectedTab)
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: .previewViewModel())
    }
}

#endif
