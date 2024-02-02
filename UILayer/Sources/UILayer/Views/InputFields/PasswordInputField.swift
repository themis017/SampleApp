//
//  PasswordInputField.swift
//
//
//  Created by Themis Makedas on 2/2/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct PasswordInputField: View {
    
    @Environment(\.scenePhase)
    private var scenePhase
    
    @State
    private var showText: Bool = false
    
    let inputPrompt: String
    let inputPlaceholder: String
    
    @Binding
    var value: String
    
    @Binding
    var errorValue: PasswordValueError?
    
    public init(inputPrompt: String,
                inputPlaceholder: String,
                value: Binding<String>,
                errorValue: Binding<PasswordValueError?>) {
        
        self.inputPrompt = inputPrompt
        self.inputPlaceholder = inputPlaceholder
        self._value = value
        self._errorValue = errorValue
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(inputPrompt)
                .font(.body)
            
            HStack(spacing: 16) {
                if showText {
                    TextField(inputPlaceholder, text: $value)
                } else {
                    SecureField(inputPlaceholder, text: $value)
                }
                
                Button {
                    showText.toggle()
                } label: {
                    Image(systemName: showText ? "eye.slash.fill" : "eye.fill")
                        .foregroundStyle(Color.black)
                }
            }
            
            Divider()
                .foregroundColor(.black)
            
            if let errorValue = errorValue?.localizedErrorTitle {
                Text(errorValue)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue != .active {
                showText = false
            }
        }
    }
}
