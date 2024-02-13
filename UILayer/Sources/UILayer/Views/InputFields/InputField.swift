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
    
    @Binding
    var isValidating: Bool
    
    public init(inputPrompt: String,
                inputPlaceholder: String,
                value: Binding<String>,
                errorValue: Binding<ErrorValue?>,
                isValidating: Binding<Bool> = .constant(false)) {
        
        self.inputPrompt = inputPrompt
        self.inputPlaceholder = inputPlaceholder
        self._value = value
        self._errorValue = errorValue
        self._isValidating = isValidating
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(inputPrompt)
                .font(.body)
            
            HStack(spacing: 0) {
                TextField(inputPlaceholder, text: $value, axis: .vertical)
                    .textFieldStyle(.plain)
                    .lineLimit(3)
                
                Spacer()
                
                if isValidating {
                    ProgressView()
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
    }
}
