//
//  UserProfileView.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI

public struct UserProfileView: View {
    
    @ObservedObject
    private var viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("UserProfileView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.blue)
            
            Button {
                viewModel.perform(.showFirstSettings)
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

struct UserProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserProfileView(viewModel: .previewViewModel())
    }
}

#endif
