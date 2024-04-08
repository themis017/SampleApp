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
    
    @FocusState
    private var focusedField: SignupViewModel.FocusedField?
    
    public init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    InputField(
                        inputPrompt: "Email",
                        inputPlaceholder: "Enter email address",
                        value: $viewModel.email,
                        errorValue: $viewModel.emailError,
                        isValidating: $viewModel.isValidatingEmail
                    )
                    .focused($focusedField, equals: .email)
                    
                    InputField(
                        inputPrompt: "Username",
                        inputPlaceholder: "Enter username",
                        value: $viewModel.username,
                        errorValue: $viewModel.usernameError,
                        isValidating: $viewModel.isValidatingUsername
                    )
                    .focused($focusedField, equals: .username)
                    
                    InputField(
                        inputPrompt: "Name",
                        inputPlaceholder: "Enter name",
                        value: $viewModel.name,
                        errorValue: $viewModel.nameError
                    )
                    .focused($focusedField, equals: .name)
                    
                    PasswordInputField(
                        inputPrompt: "Password",
                        inputPlaceholder: "Enter password",
                        value: $viewModel.password,
                        errorValue: $viewModel.passwordError
                    )
                    .focused($focusedField, equals: .password)
                    
                    PasswordInputField(
                        inputPrompt: "Confirm Password",
                        inputPlaceholder: "Confirm your password",
                        value: $viewModel.retypedPassword,
                        errorValue: $viewModel.retypedPasswordError
                    )
                    .focused($focusedField, equals: .retypedPassword)
                }
                .padding(16)
            }
            .onSubmit {
                if focusedField == .email {
                    focusedField = .username
                } else if focusedField == .username {
                    focusedField = .name
                } else if focusedField == .name {
                    focusedField = .password
                } else if focusedField == .password {
                    focusedField = .retypedPassword
                } else {
                    focusedField = nil
                }
            }
            
            Spacer()
            
            Button {
                viewModel.perform(.signup)
            } label: {
                Text("Sign up")
                    .flexible(.horizontal)
            }
            .buttonStyle(.primary)
            .disabled(!viewModel.isSignupEnabled)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(.white)
//        .navigationTitle("Sign up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text("Sign up")
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
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#if DEBUG

struct SignupView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SignupView(viewModel: .previewViewModel())
        }
    }
}

#endif
