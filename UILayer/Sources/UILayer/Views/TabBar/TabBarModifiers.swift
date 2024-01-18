//
//  TabBarModifiers.swift
//
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

struct TabBarModifier: ViewModifier {
    
    @Binding
    var selectedTab: TabBarCategory
    
    init(selectedTab: Binding<TabBarCategory>) {
        self._selectedTab = selectedTab
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            
            Spacer()
            
            TabBar(selectedTab: $selectedTab)
        }
    }
}

public extension View {
    
    func tabBar(selectedTab: Binding<TabBarCategory>) -> some View {
        self.modifier(TabBarModifier(selectedTab: selectedTab))
    }
}
