//
//  SecondaryButtonStyle.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled)
    private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .foregroundColor(isEnabled ? Color.secondaryButtonEnabledColor : Color.secondaryButtonDisabledColor)
            .padding(16)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isEnabled ? Color.secondaryButtonEnabledColor : Color.secondaryButtonDisabledColor, lineWidth: 2)
            )
    }
}

// MARK: ButtonStyle Extension

public extension ButtonStyle where Self == SecondaryButtonStyle {
    
    static var secondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
}
