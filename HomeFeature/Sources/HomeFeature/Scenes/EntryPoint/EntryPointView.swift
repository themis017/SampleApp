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
    
    private var appRootRouter: AppRootRouting
    
    public init(appRootRouter: AppRootRouting) {
        self.appRootRouter = appRootRouter
    }
    
    public var body: some View {
        
        VStack(spacing: 0) {
            Color.gray
        }
        .onAppear {
            appRootRouter.showHome()
        }
    }
}

