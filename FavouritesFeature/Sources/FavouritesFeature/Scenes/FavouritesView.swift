//
//  FavouritesView.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import SwiftUI

public struct FavouritesView: View {
    
    @ObservedObject
    private var viewModel: FavouritesViewModel
    
    public static let sceneIdentity = "FavouritesView"
    
    public init(viewModel: FavouritesViewModel) {
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
            if let recipes = viewModel.recipes {
                ScrollView {
                    VStack(spacing: 0) {
                                                
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                .flexible()
                .background(Color(UIColor.systemGray6))
                .navigationTitle("Favourite recipes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .alert(isPresented: $viewModel.showingRemovalAlert) {
            Alert(
                title: Text("Remove favourite recipe"),
                message: Text("Are you sure you want to remove this recipe?"),
                primaryButton: .default(Text("Cancel")),
                secondaryButton: .destructive(Text("Remove"), action: {
                    viewModel.perform(.removeRecipe)
                })
            )
        }
    }
}

#if DEBUG

struct FavouritesView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavouritesView(viewModel: .previewViewModel())
    }
}

#endif
