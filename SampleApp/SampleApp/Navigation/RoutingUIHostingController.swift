//
//  RoutingUIHostingController.swift
//  SampleApp
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

class RoutingUIHostingController<Content: View>: UIHostingController<Content> {
    
    let sceneIdentity: String
    let isRoot: Bool
    let tabCategory: TabBarCategory?
    
    init(sceneIdentity: String,
         isRoot: Bool,
         tabCategory: TabBarCategory?,
         view: Content) {
        
        self.sceneIdentity = sceneIdentity
        self.isRoot = isRoot
        self.tabCategory = tabCategory
        super.init(rootView: view)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
