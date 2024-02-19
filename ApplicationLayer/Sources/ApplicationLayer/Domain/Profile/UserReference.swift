//
//  UserReference.swift
//  
//
//  Created by Themis Makedas on 9/2/24.
//

import Foundation

public struct UserReference: Identifiable, Equatable {
    public var id: UserProfile.ID
    
    public init(id: UserProfile.ID) {
        self.id = id
    }
}
