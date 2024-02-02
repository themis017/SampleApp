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
    
    @Environment(\.scenePhase)
    private var scenePhase
    
    @ObservedObject
    private var viewModel: SignupViewModel
    
    public static let sceneIdentity = "SignupView"
    
    @FocusState
    private var focusedField: SignupViewModel.FocusedField?
    
    @State
    private var showPasswordText: Bool = false
    
    @State
    private var showRetypedPasswordText: Bool = false
    
    public init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email")
                                .font(.body)
                            
                            TextField("Enter email address", text: $viewModel.email)
                                .textFieldStyle(.plain)
                                .focused($focusedField, equals: .email)
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            if let emailError = viewModel.emailError {
                                Text(emailError.errorDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Username")
                                .font(.body)
                            
                            TextField("Enter username", text: $viewModel.username)
                                .textFieldStyle(.plain)
                                .focused($focusedField, equals: .username)
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            if let usernameError = viewModel.usernameError {
                                Text(usernameError.errorDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name")
                                .font(.body)
                            
                            TextField("Enter name", text: $viewModel.name)
                                .textFieldStyle(.plain)
                                .focused($focusedField, equals: .name)
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            if let nameError = viewModel.nameError {
                                Text(nameError.errorDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password")
                                .font(.body)
                            
                            HStack(spacing: 16) {
                                if showPasswordText {
                                    TextField("Enter password", text: $viewModel.password)
                                        .focused($focusedField, equals: .password)
                                } else {
                                    SecureField("Enter password", text: $viewModel.password)
                                        .focused($focusedField, equals: .password)
                                }
                                
                                Button {
                                    showPasswordText.toggle()
                                } label: {
                                    Image(systemName: showPasswordText ? "eye.slash.fill" : "eye.fill")
                                        .foregroundStyle(Color.black)
                                }
                            }
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            if let passwordError = viewModel.passwordError {
                                Text(passwordError.errorDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Confirm Password")
                                .font(.body)
                            
                            HStack(spacing: 16) {
                                if showRetypedPasswordText {
                                    TextField("Confirm your password", text: $viewModel.retypedPassword)
                                        .focused($focusedField, equals: .retypedPassword)
                                } else {
                                    SecureField("Confirm your password", text: $viewModel.retypedPassword)
                                        .focused($focusedField, equals: .retypedPassword)
                                }
                                
                                Button {
                                    showRetypedPasswordText.toggle()
                                } label: {
                                    Image(systemName: showRetypedPasswordText ? "eye.slash.fill" : "eye.fill")
                                        .foregroundStyle(Color.black)
                                }
                            }
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            if let retypedPasswordError = viewModel.retypedPasswordError {
                                Text(retypedPasswordError.errorDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding(.bottom, 16)
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
                
                Button(action: {
                    viewModel.perform(.signup)
                }) {
                    Text("Sign up")
                        .flexible(.horizontal)
                }
                .buttonStyle(.primary)
                .disabled(!viewModel.isSignupEnabled)
            }
            .padding(16)
            .background(.white)
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
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue != .active {
                showPasswordText = false
                showRetypedPasswordText = false
            }
        }
        .onChange(of: focusedField) { newValue in
            viewModel.perform(.focusedField(of: newValue))
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
