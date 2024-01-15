//
//  HomeRouter.swift
//  SampleApp
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import SwiftUI
import ApplicationLayer
import MainFeature
import HomeFeature
import UserProfileFeature

class HomeRouter: BaseRouter, HomeRouting {
        
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
}
