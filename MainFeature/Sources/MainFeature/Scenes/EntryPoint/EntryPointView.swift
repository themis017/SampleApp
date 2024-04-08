//
//  EntryPointView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct EntryPointView: View {
    
    @ObservedObject
    private var viewModel: EntryPointViewModel
    
    public static let sceneIdentity = "EntryPointView"
    
    public init(viewModel: EntryPointViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        ZStack {
            Color.white
            
            VStack(spacing: 0) {
                Text("Welcome to SampleApp")
                    .font(.title)
                    .foregroundStyle(.black)
                    .flexible(.horizontal)
                
                Text("Find out what will you cook today!")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .flexible(.horizontal)
                    .padding(.top, 8)
                
                Button {
                    viewModel.perform(.showSignup)
                } label: {
                    Text("Sign up")
                        .flexible(.horizontal)
                }
                .buttonStyle(.primary)
                .padding(.top, 48)
                
                Button {
                    viewModel.perform(.showLogin)
                } label: {
                    Text("Log in")
                        .flexible(.horizontal)
                }
                .buttonStyle(.secondary)
                .padding(.top, 16)

            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG

struct EntryPointView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            EntryPointView(viewModel: .previewViewModel())
        }
    }
}

#endif
