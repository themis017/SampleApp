//
//  FirstSettingsView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct FirstSettingsView: View {
    
    @ObservedObject
    private var viewModel: FirstSettingsViewModel
    
    public init(viewModel: FirstSettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("FirstSettingsView")
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

struct FirstSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        FirstSettingsView(viewModel: .previewViewModel())
    }
}

#endif
