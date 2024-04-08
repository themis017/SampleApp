//
//  LandingView.swift
//
//
//  Created by Themis Makedas on 27/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct LandingView: View {
    
    @ObservedObject
    private var viewModel: LandingViewModel
    
    public static let sceneIdentity = "LandingView"
    
    public init(viewModel: LandingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
//        Color.red
//            .ignoresSafeArea()
//            .overlay(
//                Image("chef-hat")
//                    .resizable()
//                    .frame(width: 150, height: 150)
//                    .background(Color.yellow)
//                    .foregroundColor(.black)
//            )
        
        
        Color.white
            .ignoresSafeArea()
            .overlay(
                Image("chef-hat-waving")
                    .resizable()
                    .frame(width: 150, height: 150)
            )
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LandingView(viewModel: .previewViewModel())
    }
}

#endif
