//
//  SecondSettingsView.swift
//  
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct SecondSettingsView: View {
    
    @ObservedObject
    private var viewModel: SecondSettingsViewModel
    
    init(viewModel: SecondSettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("SecondSettingsView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.green)
            
            Button {
                viewModel.perform(.dismiss)
            } label: {
                Text("Dismiss")
                    .padding(24)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }

        }
    }
}

#if DEBUG

struct SecondSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SecondSettingsView(viewModel: .previewViewModel())
    }
}

#endif
