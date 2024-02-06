//
//  HomeRouting.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

public protocol HomeRouting: Routing {
    func showRecipe(_ recipe: Recipe)
    func showHomeDetails_A_Scene()
    func showHomeDetails_B_Scene()
}
