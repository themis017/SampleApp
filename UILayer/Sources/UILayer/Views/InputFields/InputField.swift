//
//  InputField.swift
//
//
//  Created by Themis Makedas on 2/2/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct InputField<ErrorValue: DomainValueError>: View {
    
    let inputPrompt: String
    let inputPlaceholder: String
    
    @Binding
    var value: String
    
    @Binding
    var errorValue: ErrorValue?
    
    public init(inputPrompt: String,
                inputPlaceholder: String,
                value: Binding<String>,
                errorValue: Binding<ErrorValue?>) {
        
        self.inputPrompt = inputPrompt
        self.inputPlaceholder = inputPlaceholder
        self._value = value
        self._errorValue = errorValue
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(inputPrompt)
                .font(.body)
            
            TextField(inputPlaceholder, text: $value)
                .textFieldStyle(.plain)
            
            Divider()
                .foregroundColor(.black)
            
            if let errorValue = errorValue?.localizedErrorTitle {
                Text(errorValue)
                    .font(.caption)
                    .foregroundColor(.red)
            }

        }
    }
}
