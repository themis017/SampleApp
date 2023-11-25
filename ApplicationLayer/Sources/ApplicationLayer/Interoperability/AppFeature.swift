//
//  AppFeature.swift
//  
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation
import Resolver

public struct AppFeature {
    
    public let name: String
    private let dependenciesRegistration: (Resolver) -> Void
   
    public init(_ name: String = "",
                dependencies dependenciesRegistration: @escaping (Resolver) -> Void = {_ in }) {
        
        self.name = name
        self.dependenciesRegistration = dependenciesRegistration
    }
   
    func initialize(using container: Resolver) {
        dependenciesRegistration(container)
    }
}
