//
//  SearchView.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import SwiftUI

public struct SearchView: View {
    
    @ObservedObject
    private var viewModel: SearchViewModel
    
    public static let sceneIdentity = "SearchView"
    
    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("SearchView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.yellow)
            
//            if let temp = viewModel.temp {
//                Text(String(temp))
//                    .font(.title)
//            }
            
            Spacer()
            
            Button {
                viewModel.perform(.nextAction)
            } label: {
                Text("Next")
                    .padding(24)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            

        }
        .background(Color.green)
    }
}

#if DEBUG

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(viewModel: .previewViewModel())
    }
}

#endif
