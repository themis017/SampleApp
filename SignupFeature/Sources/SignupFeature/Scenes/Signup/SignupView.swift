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
            
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email")
                                .font(.body)
                            
                            TextField("Add your email address", text: $viewModel.email)
                                .textFieldStyle(.plain)
                            
                            Divider()
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Username")
                                .font(.body)
                            
                            TextField("Add your username", text: $viewModel.username)
                                .textFieldStyle(.plain)
                            
                            Divider()
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name")
                                .font(.body)
                            
                            TextField("Add your name", text: $viewModel.name)
                                .textFieldStyle(.plain)
                            
                            Divider()
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password")
                                .font(.body)
                            
                            SecureField("Add your password", text: $viewModel.password)
                                .textFieldStyle(.plain)
                            
                            Divider()
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Confirm Password")
                                .font(.body)
                            
                            SecureField("Confirm your password", text: $viewModel.retypedPassword)
                                .textFieldStyle(.plain)
                            
                            Divider()
                                .foregroundColor(.black)
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
