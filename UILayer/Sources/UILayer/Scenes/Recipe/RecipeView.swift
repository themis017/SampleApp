//
//  RecipeView.swift
//
//
//  Created by Themis Makedas on 6/2/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct RecipeView: View {
    
    @ObservedObject
    private var viewModel: RecipeViewModel
    
    public static let sceneIdentity = "RecipeView"
    
    public init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        if let recipe = viewModel.recipe {
            
            VStack(spacing: 8) {
                
                ScrollView {
                    
                    Text(recipe.title.rawValue)
                        .font(.title)
                        .foregroundStyle(Color.black)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack(spacing: 0) {
                            Image(recipe.iconAsseTitle)
                                .resizable()
                                .frame(width: 300, height: 170)
                            
                            Spacer()
                            
                            Button {
                                viewModel.perform(.favourite(recipe))
                            } label: {
                                Image(systemName: recipe.isFavourite ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(recipe.isFavourite ? Color.yellow : Color.gray)
                                
                                
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.chefName.rawValue)
                                .font(.body)
                                .foregroundStyle(Color.black)
                            
                            Text(recipe.chefUsername.rawValue)
                                .font(.body)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Group {
                            Text(recipe.description.rawValue)
                                .font(.body)
                                .foregroundStyle(Color.black)
                            
                            Divider()
                        }
                        .padding(.top, 8)
                        
                        Group {
                            HStack(spacing: 4) {
                                Text("Serves:")
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                                
                                Text(String(recipe.serves))
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                            }
                            
                            Divider()
                        }
                        
                        Group {
                            HStack(spacing: 4) {
                                Text("Time:")
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                                
                                Text(String(recipe.totalTime))
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                            }
                            
                            Divider()
                        }
                        
                        Group {
                            HStack(spacing: 4) {
                                Text("Difficulty:")
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                                
                                if let difficulty = recipe.difficulty {
                                    HStack(spacing: 2) {
                                        ForEach(1..<6) { number in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(number > difficulty.rawValue ? Color.white : Color.yellow)
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                        }
                        
                        Group {
                            Text("Ingredients:")
                                .font(.headline)
                                .foregroundStyle(Color.black)
                            
                            Text(recipe.ingredients)
                                .font(.body)
                                .foregroundStyle(Color.black)
                            
                            Divider()
                        }
                        
                        Group {
                            Text("Method:")
                                .font(.headline)
                                .foregroundStyle(Color.black)
                            
                            Text(recipe.method)
                                .font(.body)
                                .foregroundStyle(Color.black)
                            
                            Divider()
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)
                
                Spacer()
            }
            .background(.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.perform(.dismiss(animated: true))
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    TabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                        viewModel.perform(.selectedTab(selectedTab))
                    }
                }
            }
            .safeAreaInset(edge: .top,
                           content: {
                Color.clear
                    .frame(height: 0)
                    .background(.bar)
                    .border(.black)
            })
            .slideBack {
                viewModel.perform(.dismiss(animated: true))
            }
        } else {
            EmptyView()
                .slideBack {
                    viewModel.perform(.dismiss(animated: true))
                }
        }
    }
}

#if DEBUG

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            RecipeView(viewModel: .previewViewModel())
        }
    }
}

#endif

