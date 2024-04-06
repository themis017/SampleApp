//
//  FavouritesView.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import SwiftUI
import UILayer

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
        
        if let recipes = viewModel.recipes {
            List {
                ForEach(recipes) { recipe in
                    RecipeResultRow(recipe: recipe)
                        .onTapGesture {
                            viewModel.perform(.showRecipe(recipe))
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(role: .destructive, action: {
                                viewModel.perform(.removeRecipe(recipe))
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .flexible()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Favourite recipes")
            .navigationBarTitleDisplayMode(.inline)
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
