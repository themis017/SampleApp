//
//  UploadRecipeMethodView.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UploadRecipeMethodView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    private var viewModel: UploadRecipeMethodViewModel
    
    public static let sceneIdentity = "UploadRecipeMethodView"
    
    public init(viewModel: UploadRecipeMethodViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                    
                SegmentedProgressBar(numberOfSegments: 4, currentSegment: 4)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                
                
                
                Spacer()
                
            }
            .navigationTitle("Upload image")
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
        }
        .slideBack {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#if DEBUG

struct UploadRecipeMethodView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeMethodView(viewModel: .previewViewModel())
    }
}

#endif
