//
//  SlideBack.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import SwiftUI

struct SlideBackViewModifier: ViewModifier {
    
    @State
    private var offset: CGSize = .zero
    
    private let onDismiss: () -> Void
    
    init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
    
    func body(content: Content) -> some View {
        content
            .flexible()
            .background(Color.white)
            .offset(x: offset.width)
            .onTapGesture {
                // MARK: Maybe fix when gesture is applied on ScrollView
            }
            .highPriorityGesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            offset = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if abs(value.translation.width) < (UIScreen.main.bounds.width / 2) {
                                offset = .zero
                            } else {
                                onDismiss()
                            }
                        }
                    }
            )
    }
}

public extension View {
    
    func slideBack(onDismiss: @escaping () -> Void) -> some View {
        self.modifier(SlideBackViewModifier(onDismiss: onDismiss))
    }
}
