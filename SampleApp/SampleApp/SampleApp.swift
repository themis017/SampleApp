//
//  SampleApp.swift
//  SampleApp
//
//  Created by Themis Makedas on 21/11/23.
//

import Foundation
import SwiftUI

@main
struct SampleApp: App {
    
//    @UIApplicationDelegateAdaptor
//    var delegate: AppDelegate
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
