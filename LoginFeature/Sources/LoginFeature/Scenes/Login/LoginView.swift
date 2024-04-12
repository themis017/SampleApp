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
    
    @FocusState
    private var focusedField: LoginViewModel.FocusedField?
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        InputField(
                            inputPrompt: "Username",
                            inputPlaceholder: "Enter username",
                            value: $viewModel.username,
                            errorValue: $viewModel.usernameError
                        )
                        .focused($focusedField, equals: .username)
                        
                        PasswordInputField(
                            inputPrompt: "Password",
                            inputPlaceholder: "Enter password",
                            value: $viewModel.password,
                            errorValue: $viewModel.passwordError
                        )
                        .focused($focusedField, equals: .password)
                    }
                    .padding(16)
                }
                .onSubmit {
                    if focusedField == .username {
                        focusedField = .password
                    } else {
                        focusedField = nil
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.perform(.login)
                }) {
                    Text("Log in")
                        .flexible(.horizontal)
                }
                .buttonStyle(.primary)
                .disabled(!viewModel.isLoginEnabled)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
            .background(.white)
            //        .navigationTitle("Log in")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    Text("Log in")
                        .font(.title3)
                        .foregroundStyle(Color.black)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.perform(.dismiss)
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .onChange(of: focusedField) { newValue in
                viewModel.perform(.focusedField(of: newValue))
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .navigationBarHidden(true)
    }
}

#if DEBUG

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(viewModel: .previewViewModel())
    }
}

#endif

