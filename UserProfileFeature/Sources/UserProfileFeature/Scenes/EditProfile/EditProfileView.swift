//
//  EditProfileView.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation
import SwiftUI
import ApplicationLayer
import UILayer

public struct EditProfileView: View {
    
    @ObservedObject
    private var viewModel: EditProfileViewModel
    
    public static let sceneIdentity = "EditProfileView"
    
    public init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray6
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                ScrollView {
                    
                    VStack(spacing: 24) {
                        
                        Button {
                            viewModel.perform(.uplaodImage)
                        } label: {
                            Image("user")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.black)
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "camera")
                                        .foregroundStyle(Color.black)
                                        .padding(2)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                        }
                        .padding(.top, 16)
                        
                        InputField(
                            inputPrompt: "Email:",
                            inputPlaceholder: "",
                            value: $viewModel.email,
                            errorValue: $viewModel.emailError,
                            isValidating: $viewModel.isValidatingEmail
                        )
                        
                        InputField(
                            inputPrompt: "Username:",
                            inputPlaceholder: "",
                            value: $viewModel.username,
                            errorValue: $viewModel.usernameError,
                            isValidating: $viewModel.isValidatingUsername
                        )
                        
                        InputField(
                            inputPrompt: "Name:",
                            inputPlaceholder: "",
                            value: $viewModel.name,
                            errorValue: $viewModel.nameError
                        )
                        
                        InputField(
                            inputPrompt: "Description:",
                            inputPlaceholder: "",
                            value: $viewModel.description,
                            errorValue: $viewModel.descriptionError
                        )
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
                Button {
                    viewModel.perform(.save)
                } label: {
                    Text("Save")
                        .flexible(.horizontal)
                }
                .buttonStyle(.primary)
                .disabled(!viewModel.isSaveEnabled)
                .padding(16)
            }
            .background(Color(UIColor.systemGray6))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("Edit profile")
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
            .slideBack {
                viewModel.perform(.dismiss)
            }
            .tabBar(selectedTab: viewModel.selectedTab) { selectedTab in
                viewModel.perform(.selectedTab(selectedTab))
            }
        }
    }
}

#if DEBUG

struct EditProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditProfileView(viewModel: .previewViewModel())
    }
}

#endif