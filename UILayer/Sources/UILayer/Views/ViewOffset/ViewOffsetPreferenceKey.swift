//
//  ViewOffsetPreferenceKey.swift
//
//
//  Created by Themis Makedas on 24/2/24.
//

import Foundation
import SwiftUI

public struct ViewOffsetPreferenceKey: PreferenceKey {
    
    public static var defaultValue: CGFloat = 0
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
