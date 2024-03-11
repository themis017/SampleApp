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
    
    @ObservedObject
    private var viewModel: UploadRecipeImageViewModel
    
    public static let sceneIdentity = "UploadRecipeImageView"
    
    public init(viewModel: UploadRecipeImageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            VStack(spacing: 16) {
                Text("UploadRecipeImageView")
                
                NavigationLink(destination: UploadRecipeNameView(
                    viewModel: viewModel.makeUploadRecipeNameViewModel())) {
                   
                    Text("Go To Upload Recipe Name View")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Add your recipe's image")
            .navigationBarTitleDisplayMode(.inline)
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
