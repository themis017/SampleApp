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
    }
    
    public var body: some View {
        
        NavigationView {
            
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        Text("Favourite recipes")
                            .font(.title3)
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            Divider()
                .background(Color.tabBarBackgroundColor)
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
