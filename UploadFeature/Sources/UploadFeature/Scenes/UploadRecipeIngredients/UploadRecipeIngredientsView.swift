//
//  UploadRecipeIngredientsView.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UploadRecipeIngredientsView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    private var viewModel: UploadRecipeIngredientsViewModel
    
    @State 
    var text = "\u{2022} "
    
    public static let sceneIdentity = "UploadRecipeIngredientsView"
    
    public init(viewModel: UploadRecipeIngredientsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            SegmentedProgressBar(numberOfSegments: 4, currentSegment: 3)
                .padding(.top, 16)
            
            Text("Ingredients")
                .font(.headline)
            
            TextEditor(text: $text)
                .colorMultiply(Color(UIColor.systemGray6))
                .frame(minHeight: 200, maxHeight: 400)
                .onChange(of: text) { newText in
                    if newText.count > viewModel.ingredients.count {
                        var lines = newText.split(separator: "\n", omittingEmptySubsequences: false)
                        for (index, _) in lines.enumerated() {
                            if !lines[index].starts(with: "\u{2022}") {
                                lines[index] = "\u{2022} " + lines[index]
                            }
                        }
                        
                        text = lines.joined(separator: "\n")
                    } else {
                        text = newText
                    }
                    
                    viewModel.ingredients = text
                }
            
            Spacer()
            
            NavigationLink(destination: UploadRecipeMethodView(
                viewModel: viewModel.makeUploadRecipeMethodViewModel())) {
                    
                    Text("Continue")
                        .font(.title3)
                        .foregroundColor(.white)
                        .flexible(.horizontal)
                        .padding(.vertical, 16)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .frame(width: 24, height: 24)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.perform(.dismiss)
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
}

#if DEBUG

struct UploadRecipeIngredientsView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeIngredientsView(viewModel: .previewViewModel())
    }
}

#endif
