//
//  RecipeResultRow.swift
//
//
//  Created by Themis Makedas on 20/2/24.
//
 
import SwiftUI
import ApplicationLayer

public struct RecipeResultRow: View {
    
    let recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 16) {
                
                Image(recipe.iconAsseTitle)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(recipe.title)
                        .font(.body)
                        .foregroundStyle(Color.black)
                    
                    Text(recipe.chefName.rawValue)
                        .font(.body)
                        .foregroundStyle(Color.black)
                }
                
                Spacer()
            }
            .background(Color.white)
            
            Image(systemName: recipe.isFavourite ? "star.fill" : "star")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(recipe.isFavourite ? Color.yellow : Color.gray)
        }
    }
}
