//
//  SelectedTabEvent.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation

public class SelectedTabEvent: AppEvent {
    
    public var id: UUID
    public var name: String
    public var type: EventType
    public var userInfo: [String : Any]
    
    public init() {
        self.id = UUID()
        self.name = "SelectedTabEvent"
        self.type = .selectedTab
        self.userInfo = [:]
    }
}
