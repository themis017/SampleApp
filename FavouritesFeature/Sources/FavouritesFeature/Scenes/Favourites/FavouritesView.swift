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
//                .background(Color(UIColor.red))
                //            .navigationTitle("Favourite recipes")
                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarBackButtonHidden(true)
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
//        .ignoresSafeArea()
//        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
//            Color.red
//                .frame(height: 20)
//                .background(Material.bar)
//        }
        .safeAreaInset(edge: .bottom) {
            Divider()
                .background(Color(UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)))
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
