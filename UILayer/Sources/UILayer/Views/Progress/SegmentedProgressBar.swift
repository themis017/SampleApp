//
//  SegmentedProgressBar.swift
//
//
//  Created by Themis  on 29/3/24.
//

import Foundation
import SwiftUI

public struct SegmentedProgressBar: View {
    
    let numberOfSegments: Int
    let currentSegment: Int
    
    private let spaceBetweenSteps = 8.0
    
    public init(numberOfSegments: Int, currentSegment: Int) {
        self.numberOfSegments = numberOfSegments
        self.currentSegment = currentSegment
    }
    
    public var body: some View {
        
        HStack(spacing: spaceBetweenSteps) {
            ForEach(0..<numberOfSegments, id: \.self) { index in
                Rectangle()
                    .foregroundColor(index < currentSegment ? .accentColor : Color.primaryButtonDisabledColor)
                    .flexible(.horizontal)
            }
        }
        .frame(height: 5)
    }
}
