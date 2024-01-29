//
//  LoginView.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer

public struct LoginView: View {
    
    @ObservedObject
    private var viewModel: LoginViewModel
    
    public static let sceneIdentity = "LoginView"
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        ZStack {
            Color.cyan.opacity(0.3)
            
            VStack(spacing: 0) {
                Spacer()
                
                Text("LoginView")
                    .font(.title)
                    .foregroundStyle(.black)
                    .flexible(.horizontal)
                
                Spacer()

            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }
}

#if DEBUG

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(viewModel: .previewViewModel())
    }
}

#endif
