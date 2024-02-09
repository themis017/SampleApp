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
        
        NavigationView {
            
            if let recipe = viewModel.recipe {
                VStack(spacing: 8) {
                    
                    Text(recipe.title)
                        .font(.title)
                        .foregroundStyle(Color.black)
                    
                    ScrollView {
                        
                        Image(recipe.iconAsseTitle)
                            .resizable()
//                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 170)
                        
                        VStack(spacing: 4) {
                            Text(recipe.chefName)
                                .font(.body)
                                .foregroundStyle(Color.black)

                            Text(recipe.chefUsername)
                                .font(.body)
                                .foregroundStyle(Color.black)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        
                        VStack(alignment: .leading, spacing: 16) {

                            Group {
                                Text(recipe.description)
                                    .font(.body)
                                    .foregroundStyle(Color.black)
                                
                                Divider()
                            }

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
//                .navigationTitle(recipe.title)
                .navigationBarTitleDisplayMode(.inline)
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
                }
                .slideBack {
                    viewModel.perform(.dismiss(animated: true))
                }
                .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                    viewModel.perform(.selectedTab(selectedTab))
                }
            } else {
                EmptyView()
                    .slideBack {
                        viewModel.perform(.dismiss(animated: false))
                    }
                    .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                        viewModel.perform(.selectedTab(selectedTab))
                    }
            }
        }
        .background(Color.white)
    }
}

#if DEBUG

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeView(viewModel: .previewViewModel())
    }
}

#endif

