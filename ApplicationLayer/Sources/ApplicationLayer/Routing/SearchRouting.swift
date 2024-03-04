//
//  SearchRouting.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation

public protocol SearchRouting: Routing {
    
    func showRecipe(_ recipe: Recipe)
    func showUser(_ user: UserReference)
}
