//
//  UploadRecipeImageView.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UploadRecipeImageView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    private var viewModel: UploadRecipeImageViewModel
    
    public static let sceneIdentity = "UploadRecipeImageView"
    
    public init(viewModel: UploadRecipeImageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        switch viewModel.uploadRecipeImageScene {
        case .imagePicker:
            imagePicker
        case .unauthorizedPhotoLibrary:
            UnauthorizedPhotoLibraryView {
                viewModel.perform(.showRecipeImage)
            }
        case .unauthorizedCamera:
            UnauthorizedCameraView {
                viewModel.perform(.showRecipeImage)
            }
        case .recipeImage:
            selectRecipeImage
        }
    }
    
    private var imagePicker: some View {
        ImagePickerView(
            selectedImage: $viewModel.selectedImage,
            sourceType: viewModel.pickerSourceType) {
                viewModel.perform(.showRecipeImage)
            }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private var selectRecipeImage: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                
                if let selectedImage = viewModel.selectedImage {
                    VStack(spacing: 16) {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(maxHeight: 300)
                            .flexible(.horizontal)
                            .padding(16)
                        
                        Button {
                            withAnimation {
                                viewModel.selectedImage = nil
                            }
                        } label: {
                            Text("Clear selection")
                                .foregroundStyle(Color.blue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                } else {
                    Button {
                        viewModel.isConfirmationDialogPresented = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 3)
                                .frame(maxHeight: 300)
                                .padding(16)
                            
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundStyle(Color.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                
                
                Spacer()
                
                NavigationLink(destination: UploadRecipeNameView(
                    viewModel: viewModel.makeUploadRecipeNameViewModel())) {
                        
                        Text("Continue")
                            .foregroundColor(.white)
                            .flexible(.horizontal)
                            .padding(.vertical, 16)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                            }
                            .padding(.horizontal, 16)
                    }
            }
            .confirmationDialog("Upload a photo from your ...", isPresented: $viewModel.isConfirmationDialogPresented, titleVisibility: .visible) {
                Button("Photo library") {
                    viewModel.perform(.selectedPhotoLibrary)
                }
                
                Button("Camera") {
                    viewModel.perform(.selectedCamera)
                }
            }
            .navigationTitle("Add your recipe's image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
        }
    }
}

#if DEBUG

struct UploadRecipeImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeImageView(viewModel: .previewViewModel())
    }
}

#endif
