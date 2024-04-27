//
//  UIColor+Extensions.swift
//
//
//  Created by Themis  on 16/4/24.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

public extension UIColor {
    
    // MARK: Primary Button
    
    static let primaryButtonEnabledColor = UIColor(red: 71, green: 120, blue: 255)
    static let primaryButtonDisabledColor = UIColor(red: 210, green: 210, blue: 210)
    
    // MARK: Secondary Button
    
    static let secondaryButtonEnabledColor = UIColor(red: 71, green: 120, blue: 255)
    static let secondaryButtonDisabledColor = UIColor(red: 210, green: 210, blue: 210)
    
    // MARK: Tab bar
    
    static let tabBarBackgroundColor = UIColor(red: 71, green: 120, blue: 255)
    static let tabBarCategoryPrimaryColor = UIColor(red: 255, green: 255, blue: 255)
    static let tabBarCategorySecondaryColor = UIColor(red: 195, green: 195, blue: 195)
}
