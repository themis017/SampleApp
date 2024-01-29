//
//  SignupView.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer

public struct SignupView: View {
    
    @ObservedObject
    private var viewModel: SignupViewModel
    
    public static let sceneIdentity = "SignupView"
    
    public init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            ZStack {
                Color.cyan.opacity(0.3)
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    Text("SignupView")
                        .font(.title)
                        .foregroundStyle(.black)
                        .flexible(.horizontal)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Sign up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.perform(.dismiss)
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                    }
                }
                
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        // handle tap
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                    Button(action: {
//                        // handle tap
//                    }) {
//                        Image(systemName: "ellipsis")
//                    }
//                }
            }
//            .ignoresSafeArea(edges: .all)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#if DEBUG

struct SignupView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignupView(viewModel: .previewViewModel())
    }
}

#endif
