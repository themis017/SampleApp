//
//  EntryPointView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct EntryPointView: View {
    
    @ObservedObject
    private var viewModel: EntryPointViewModel
    
    public static let sceneIdentity = "EntryPointView"
    
    public init(viewModel: EntryPointViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 0) {
            Color.gray
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                viewModel.perform(.showMain)
            }
        }
    }
}

