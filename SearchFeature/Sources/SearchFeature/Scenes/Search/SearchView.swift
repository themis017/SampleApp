//
//  SearchView.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import SwiftUI

public struct SearchView: View {
    
    @ObservedObject
    private var viewModel: SearchViewModel
    
    public static let sceneIdentity = "SearchView"
    
    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    private var recipesColumns: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 16),
        GridItem(.flexible(minimum: 100), spacing: 16)
    ]
    
    private var usersColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public var body: some View {
        
        VStack(spacing: 0) {
            
            if !viewModel.isSearching {
                switch viewModel.searchFilter {
                case .recipes:
                    popularRecipesView
                case .users:
                    popularUsersView
                }
            } else {
                switch viewModel.searchFilter {
                case .recipes:
                    searchedRecipesView
                case .users:
                    searchedUsersView
                }
            }
        }
        .searchable(text: $viewModel.searchQuery)
        .onSubmit(of: .search) {
            viewModel.perform(.searchResults)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Temp text")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                menuView
            }
        }
//        .navigationTitle("")
//        .navigationTitle(viewModel.searchFilter == .recipes ? "Search recipes" : "Search Users")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var menuView: some View {
        Menu {
            Section("Filter results by") {
                Button {
                    viewModel.perform(.changeFilter(to: .recipes))
                } label: {
                    if viewModel.searchFilter == .recipes {
                        Label("Recipes", systemImage: "checkmark.circle.fill")
                    } else {
                        Text("Recipes")
                    }
                }
                
                Button {
                    viewModel.perform(.changeFilter(to: .users))
                } label: {
                    if viewModel.searchFilter == .users {
                        Label("Users", systemImage: "checkmark.circle.fill")
                    } else {
                        Text("Users")
                    }
                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundStyle(Color.black)
        }
    }
    
    private var popularRecipesView: some View {
        VStack(spacing: 8) {
            Text("Most popular recipes")
                .font(.headline)
                .flexible(.horizontal, alignment: .leading)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVGrid(
                    columns: recipesColumns,
                    alignment: .center,
                    spacing: 16
                ) {
                    ForEach(viewModel.popularRecipes) { recipe in
                        
                        Button {
                            viewModel.perform(.showRecipe(recipe))
                        } label: {
                            Image(recipe.iconAsseTitle)
                                .resizable()
                                .flexible(.horizontal)
                                .frame(maxHeight: 150)
                                .overlay(alignment: .bottomLeading) {
                                    Text(recipe.title.rawValue)
                                        .font(.body)
                                        .foregroundStyle(Color.black)
                                        .padding(.horizontal, 8)
                                        .background(Color.white.opacity(0.8))
                                        .clipShape(Capsule())
                                }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private var searchedRecipesView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.searchedRecipes) { recipe in
                    
                    Button {
                        viewModel.perform(.showRecipe(recipe))
                    } label: {
                        Image(recipe.iconAsseTitle)
                            .resizable()
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(alignment: .bottomLeading) {
                                Text(recipe.title.rawValue)
                                    .font(.title2)
                                    .foregroundStyle(Color.black)
                                    .background(Color.white.opacity(0.8))
                            }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private var popularUsersView: some View {
        VStack(spacing: 8) {
            Text("Most popular users")
                .font(.headline)
                .flexible(.horizontal, alignment: .leading)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVGrid(
                    columns: usersColumns,
                    alignment: .center,
                    spacing: 16
                ) {
                    ForEach(viewModel.popularUsers) { user in
                        
                        Button {
                            viewModel.perform(.showUser(user))
                        } label: {
                            VStack(spacing: 0) {
                                Image("user")
                                    .resizable()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 64, height: 64)
                                    .padding(.bottom, 16)
                                
                                Text(user.username.rawValue)
                                    .font(.body)
                                    .foregroundStyle(Color.gray)
                                    .padding(.bottom, 2)
                                
                                Text(user.name.rawValue)
                                    .font(.body)
                                    .foregroundStyle(Color.gray)
                                
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 48)
                            .background(Color.gray.opacity(0.1))
                            .overlay(
                                Button {
                                    viewModel.perform(.removeUser(user))
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .foregroundStyle(Color.gray)
                                        .frame(width: 16, height: 16)
                                        .offset(x: -10, y: 10)
                                },
                                alignment: .topTrailing
                            )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private var searchedUsersView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.searchedUsers) { user in
                    HStack(spacing: 16) {
                        Image("user")
                            .resizable()
                            .frame(width: 48, height: 48)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name.rawValue)
                                .font(.headline)
                                .foregroundStyle(Color.black)
                            
                            Text(user.username.rawValue)
                                .font(.body)
                                .foregroundStyle(Color.black)
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.perform(.showUser(user))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

#if DEBUG

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(viewModel: .previewViewModel())
    }
}

#endif
