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
    
    @State 
    var text = "1. "
    
    var currentMethodStep = 1
    
    public static let sceneIdentity = "UploadRecipeMethodView"
    
    public init(viewModel: UploadRecipeMethodViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            SegmentedProgressBar(numberOfSegments: 4, currentSegment: 4)
                .padding(.top, 16)
            
            Text("Methodology")
                .font(.headline)
            
            TextEditor(text: $text)
                .colorMultiply(Color(UIColor.systemGray6))
                .frame(minHeight: 200, maxHeight: 400)
                .onChange(of: text) { newText in
                    if newText.count > viewModel.method.count {
                        var lines = newText.split(separator: "\n", omittingEmptySubsequences: false)
                        for (index, _) in lines.enumerated() {
                            if !lines[index].starts(with: "\(index + 1).") {
                                lines[index] = "\(index + 1). " + lines[index]
                            }
                        }
                        
                        text = lines.joined(separator: "\n")
                    } else {
                        text = newText
                    }
                    
                    viewModel.method = text
                }
            
            Spacer()
            
            Button {
                viewModel.perform(.upload)
            } label: {
                Text("Upload")
                    .flexible(.horizontal)
            }
            .buttonStyle(.primary)
            .padding(.bottom, 16)
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

struct UploadRecipeMethodView_Previews: PreviewProvider {
    
    static var previews: some View {
        UploadRecipeMethodView(viewModel: .previewViewModel())
    }
}

#endif
