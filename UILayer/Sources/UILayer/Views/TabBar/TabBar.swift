//
//  TabBar.swift
//
//
//  Created by Themis Makedas on 18/1/24.
//

import Foundation
import SwiftUI
import ApplicationLayer

public struct TabBar: View {

    var selectedTab: TabBarCategory
    let action: (TabBarCategory) -> Void
        
    public init(selectedTab: TabBarCategory,
                action: @escaping (TabBarCategory) -> Void) {
        
        self.selectedTab = selectedTab
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            
            Divider()
                .foregroundColor(.gray)
            
            HStack(spacing: 0) {
                ForEach(TabBarCategory.allCases, id: \.self) { tabBarCategory in
                    Button {
                        withAnimation {
                            action(tabBarCategory)
                        }
                    } label: {
                        VStack(spacing: 4) {
                            
                            Image(systemName: tabBarCategory.iconTitle)
                                .frame(width: 24, height: 24)
                            
                            Text(tabBarCategory.title)
                                .font(.caption)
                        }
                        .foregroundColor(selectedTab == tabBarCategory ? .blue : .gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 6)
        }
    }
}

#if DEBUG

struct TabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBar(selectedTab: .home) { selectedTab in
            
        }
    }
}

#endif
