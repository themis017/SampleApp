//
//  StringExtensions.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation
import SwiftUI

public extension String {
    
    func isEmpty() -> Bool {
        self.count == 0 ? true : false
    }
    
    func matches(_ pattern: String) -> Bool {
        do {
            let range = NSRange(location: 0, length: self.utf16.count)
            let regularExpression = try NSRegularExpression(pattern: pattern)
            return regularExpression.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            return false
        }
    }
}
