//
//  HomeDetails_B_View.swift
//
//
//  Created by Themis Makedas on 19/1/24.
//

import Foundation
import SwiftUI

public struct HomeDetails_B_View: View {
    
    @ObservedObject
    private var viewModel: HomeDetails_B_ViewModel
    
    public static let sceneIdentity = "HomeDetails_B_View"
    
    public init(viewModel: HomeDetails_B_ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("HomeDetails_B_View")
                .padding(16)
                .foregroundColor(.blue)
                .background(Color.white)
            
            Spacer()
            
            Button {
                viewModel.perform(.nextAction)
            } label: {
                Text("Next")
                    .padding(24)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            

        }
        .background(Color.green)
        .tabBar(selectedTab: .constant(.home)) { selectedTab in
            viewModel.perform(.selectedTab(selectedTab))
        }
    }
}

#if DEBUG

struct HomeDetails_B_View_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeDetails_B_View(viewModel: .previewViewModel())
    }
}

#endif
