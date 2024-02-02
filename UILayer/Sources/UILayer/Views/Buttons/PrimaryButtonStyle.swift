//
//  PrimaryButtonStyle.swift
//
//
//  Created by Themis Makedas on 29/1/24.
//

import Foundation
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled)
    private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .bold()
            .foregroundColor(.white)
            .padding(16)
            .background(isEnabled ? .blue : Color(UIColor.lightGray))
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
    }
}

// MARK: ButtonStyle Extension

public extension ButtonStyle where Self == PrimaryButtonStyle {
    
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
