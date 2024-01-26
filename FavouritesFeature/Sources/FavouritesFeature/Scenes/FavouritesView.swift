//
//  FavouritesView.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import SwiftUI

public struct FavouritesView: View {
    
    @ObservedObject
    private var viewModel: FavouritesViewModel
    
    public static let sceneIdentity = "FavouritesView"
    
    public init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack(spacing: 16) {
            Text("FavouritesView")
                .padding(16)
                .foregroundColor(.white)
                .background(Color.yellow)
            
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

struct FavouritesView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavouritesView(viewModel: .previewViewModel())
    }
}

#endif
