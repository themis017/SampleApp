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
    
    let action: (TabBarCategory) -> Void
    
    init(selectedTab: Binding<TabBarCategory>,
         action: @escaping (TabBarCategory) -> Void) {
        
        self._selectedTab = selectedTab
        self.action = action
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            
            Spacer()
            
            TabBar(selectedTab: $selectedTab) { selectedTab in
                action(selectedTab)
            }
        }
    }
}

public extension View {
    
    func tabBar(selectedTab: Binding<TabBarCategory>, action: @escaping (TabBarCategory) -> Void) -> some View {
        self.modifier(TabBarModifier(selectedTab: selectedTab) { selectedTab in
            action(selectedTab)
        }
        )
    }
}
