//
//  ContentView.swift
//  SampleApp
//
//  Created by Themis Makedas on 21/11/23.
//

import SwiftUI
import ApplicationLayer

struct ContentView: View {
    
    private let appRootRouter: AppRootRouting
    
    public init(appRootRouter: AppRootRouting) {
        self.appRootRouter = appRootRouter
    }
    
    var body: some View {

        Text("Hello world!")
            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    appRootRouter.showEntryPoint()
//                }
                
                appRootRouter.showEntryPoint()
            }
    }
}

//#if DEBUG
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//#endif
