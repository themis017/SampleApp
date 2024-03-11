//
//  UploadRecipeNameView.swift
//
//
//  Created by Themis Makedas on 11/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UploadRecipeNameView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    private var viewModel: UploadRecipeNameViewModel
    
    public static let sceneIdentity = "UploadRecipeNameView"
    
    public init(viewModel: UploadRecipeNameViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 0) {
            Text("UploadRecipeNameView")
        }
        .navigationTitle("Add your recipe's name")
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
        }
        .slideBack {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#if DEBUG

struct UploadRecipeNameView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeNameView(viewModel: .previewViewModel())
    }
}

#endif
