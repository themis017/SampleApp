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
                            
                            SecureField("Enter password", text: $viewModel.password)
                                .textFieldStyle(.plain)
                            
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
                            
                            SecureField("Confirm your password", text: $viewModel.retypedPassword)
                                .textFieldStyle(.plain)
                            
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
            //            .ignoresSafeArea(edges: .bottom)
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
