//
//  AppEvent.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation

public protocol AppEvent {
    
    var id: UUID { get }
    var name: String { get }
    var type: EventType { get }
    var userInfo: [String : Any] { get }
}
