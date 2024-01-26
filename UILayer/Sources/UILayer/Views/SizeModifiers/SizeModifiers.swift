//
//  SizeModifiers.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import SwiftUI

struct FlexibleViewModifier: ViewModifier {
    let axis: Axis.Set
    let alignment: Alignment
    
    init(axis: Axis.Set, alignment: Alignment) {
        self.axis = axis
        self.alignment = alignment
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: axis.contains(.horizontal) ? .infinity : nil, alignment: alignment)
            .frame(maxHeight: axis.contains(.vertical) ? .infinity : nil, alignment: alignment)
    }
}

public extension View {
    
    func flexible(_ axis: Axis.Set,
                  alignment: Alignment = .center) -> some View {
        
        self.modifier(
            FlexibleViewModifier(
                axis: axis,
                alignment: alignment
            )
        )
    }
}
