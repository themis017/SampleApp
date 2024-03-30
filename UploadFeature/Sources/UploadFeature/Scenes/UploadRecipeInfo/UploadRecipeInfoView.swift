//
//  UploadRecipeInfoView.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UploadRecipeInfoView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    private var viewModel: UploadRecipeInfoViewModel
    
    public static let sceneIdentity = "UploadRecipeInfoView"
    
    public init(viewModel: UploadRecipeInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            
            SegmentedProgressBar(numberOfSegments: 4, currentSegment: 2)
//                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            InputField(
                inputPrompt: "Title",
                inputPlaceholder: "Enter title",
                value: $viewModel.recipeTitle,
                errorValue: $viewModel.recipeTitleError
            )
            
            
            
            Spacer()
            
            NavigationLink(destination: UploadRecipeIngredientsView(
                viewModel: viewModel.makeUploadRecipeIngredientsViewModel())) {
                    
                    Text("Continue")
                        .foregroundColor(.white)
                        .flexible(.horizontal)
                        .padding(.vertical, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                        }
//                        .padding(.horizontal, 16)
                }
                .disabled(!viewModel.isContinueEnabled)
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
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.black)
                }
            }
        }
        .slideBack {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#if DEBUG

struct UploadRecipeInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeInfoView(viewModel: .previewViewModel())
    }
}

#endif
