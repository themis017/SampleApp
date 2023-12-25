//
//  SettingsView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct SettingsView: View {
    
    @ObservedObject
    private var viewModel: SettingsViewModel
    
    public init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("SettingsView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.red)
            
            Button {
                viewModel.perform(.showSecondSettings)
            } label: {
                Text("Next")
                    .padding(24)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }

        }
    }
}

#if DEBUG

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(viewModel: .previewViewModel())
    }
}

#endif
