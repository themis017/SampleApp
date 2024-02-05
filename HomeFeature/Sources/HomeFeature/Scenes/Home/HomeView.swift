//
//  HomeView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct HomeView: View {
    
    @ObservedObject
    private var viewModel: HomeViewModel
    
    public static let sceneIdentity = "HomeView"
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Recipe.previewExamples) { recipe in
                        Text(recipe.title)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: .previewViewModel())
    }
}

#endif
