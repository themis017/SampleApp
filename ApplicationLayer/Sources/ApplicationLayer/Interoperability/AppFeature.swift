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
    
    /// Creates an AppFeature definition that can be composed by the application
    /// - Parameters:
    ///   - name: The name of the feature
    ///   - dependenciesRegistration: A closure forthe feature to begin registering and exposing any cross-cutting dependencies
    public init(_ name: String = "",
                dependencies dependenciesRegistration: @escaping (Resolver) -> Void = {_ in }) {
        
        self.name = name
        self.dependenciesRegistration = dependenciesRegistration
    }
    
    /// Initializes the feature and instructs it to start registration of dependencies
    /// - Parameter container: The resolver instance used as the dependency container
    func initialize(using container: Resolver) {
        dependenciesRegistration(container)
    }
}
