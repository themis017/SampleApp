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
                    ForEach(viewModel.recipes) { recipe in
                        
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
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top,
                       content: {
            Color.clear
                .frame(height: 0)
                .background(.bar)
                .border(.black)
        })
        .safeAreaInset(edge: .bottom) {
            Divider()
                .background(Color.tabBarBackgroundColor)
        }
        .refreshable {
            viewModel.perform(.refresh)
        }
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            HomeView(viewModel: .previewViewModel())
        }
    }
}

#endif
