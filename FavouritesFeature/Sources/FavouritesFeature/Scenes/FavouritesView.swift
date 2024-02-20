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
        
//        NavigationView {
//            if let recipes = viewModel.recipes {
////                ScrollView {
//                    List {
//                        ForEach(recipes) { recipe in
//                            RecipeResultRow(recipe: recipe)
//                                .onTapGesture {
//                                    viewModel.perform(.showRecipe(recipe))
//                                }
//                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                                    Button(role: .destructive, action: {
//                                        
//                                    }) {
//                                        Label("Delete", systemImage: "trash")
//                                    }
//                                }
//                        }
//                    }
////                    .padding(.horizontal, 16)
////                }
//                .flexible()
//                .background(Color(UIColor.systemGray6))
//                .navigationTitle("Favourite recipes")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
        NavigationView {
            if let recipes = viewModel.recipes {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(recipes) { recipe in
                            RecipeResultRow(recipe: recipe)
                                .onTapGesture {
                                    viewModel.perform(.showRecipe(recipe))
                                }
                        }
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
