//
//  SecondaryButtonStyle.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .bold()
            .foregroundColor(.blue)
            .padding(16)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
    }
}

// MARK: ButtonStyle Extension

public extension ButtonStyle where Self == SecondaryButtonStyle {
    
    static var secondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
}
