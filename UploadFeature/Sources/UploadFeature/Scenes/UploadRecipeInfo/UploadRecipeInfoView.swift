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
        
        VStack(alignment: .leading, spacing: 24) {
            
            SegmentedProgressBar(numberOfSegments: 4, currentSegment: 2)
                .padding(.top, 16)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    InputField(
                        inputPrompt: "Title",
                        inputPlaceholder: "Enter title",
                        value: $viewModel.recipeTitle,
                        errorValue: $viewModel.recipeTitleError
                    )
                    
                    InputEditor(
                        inputPrompt: "Description:",
                        inputPlaceholder: "",
                        value: $viewModel.description,
                        errorValue: $viewModel.descriptionError
                    )
                    .colorMultiply(Color(UIColor.systemGray6))
                    .frame(minHeight: 86, maxHeight: 140)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cooking time:")
                            .font(.headline)
                            .flexible(.horizontal, alignment: .leading)
                        
                        HStack(spacing: 0) {
                            Text("Hours:")
                                .font(.body)
                            
                            Picker("",
                                   selection: $viewModel.selectedHourIndex) {
                                ForEach(0...24, id: \.self) {
                                    Text(String($0))
                                }
                            }
                                   .pickerStyle(.menu)
                        }
                        
                        HStack(spacing: 0) {
                            Text("Minutes:")
                                .font(.body)
                            
                            Picker("",
                                   selection: $viewModel.selectedMinuteIndex) {
                                ForEach(0...60, id: \.self) {
                                    Text(String($0))
                                }
                            }
                                   .pickerStyle(.menu)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Difficulty:")
                            .font(.headline)
                        
                        HStack(spacing: 8) {
                            
                            ForEach(1...5, id: \.self) { buttonDifficulty in
                                Button {
                                    viewModel.perform(.selectedDifficulty(buttonDifficulty))
                                } label: {
                                    Image(systemName: viewModel.recipeDifficulty.rawValue >= buttonDifficulty ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(viewModel.recipeDifficulty.rawValue >= buttonDifficulty ? Color.yellow : Color.gray)
                                }
                                
                                if buttonDifficulty != 5 {
                                    Spacer()
                                }
                            }
                        }
                        
                        HStack(spacing: 0) {
                            Text("Very easy")
                                .font(.caption)
                            
                            Spacer()
                            
                            Text("Very difficult")
                                .font(.caption)
                        }
                    }
                }
                
                Spacer()
                
            }
            
            NavigationLink(destination: UploadRecipeIngredientsView(
                viewModel: viewModel.makeUploadRecipeIngredientsViewModel())) {
                    
                    Text("Continue")
                        .foregroundColor(.white)
                        .flexible(.horizontal)
                        .padding(.vertical, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                        }
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
                    viewModel.perform(.dismiss)
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
