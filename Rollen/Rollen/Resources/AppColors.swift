//
//  AppColors.swift
//  Rollen
//
//  Created by Dmitry Belov on 30.10.2024.
//

import UIKit

enum AppColors {
    static let background = AppColors.Blue.dark
    static let tabbarBackground = AppColors.Blue.dark
    static let tabbarActiveButton = AppColors.Red.light
    static let tabbarInactiveButton = AppColors.Yellow.dark
    static let addButton = AppColors.Red.dark
    static let registerTextFieldTextColor = AppColors.Yellow.medium
    static let registerTextFieldBackgroundColor = AppColors.Blue.medium
    static let MainMenuBackgroundColor = AppColors.Blue.dark
    static let MainMenuCellBackgroundColor = AppColors.Blue.medium
    static let MainMenuHeaderCellColor = AppColors.Red.light
    
    enum Blue {
        static let dark = UIColor(hex: "013145")  // Background
        static let medium = UIColor(hex: "01364B") // Tabbar Background
        static let light = UIColor(hex: "086272")
        static let darkTransparent = UIColor(hex: "013145", alpha: 0.5) // Полупрозрачный
    }
    
    enum Yellow {
        static let dark = UIColor(hex: "B7902E")   // Inactive Tabbar Button
        static let medium = UIColor(hex: "FDFF48") // Inactive Tabbar Button
        static let light = UIColor(hex: "B69A53")
        static let darkTransparent = UIColor(hex: "B7902E", alpha: 0.7)
    }
    
    enum Red {
        static let dark = UIColor(hex: "551000")   // Add Button
        static let medium = UIColor(hex: "6E1500")
        static let light = UIColor(hex: "C14D30")  // Active Tabbar Button
        static let lightTransparent = UIColor(hex: "C14D30", alpha: 0.3)
        static let darkTransparent = UIColor(hex: "551000", alpha: 0.3)
    }
}


extension UIColor {
    static var accentDarkBlue: UIColor { #colorLiteral(red: 0.003921568627, green: 0.1921568627, blue: 0.2705882353, alpha: 1) } //фон #013145
    static var accentBlue: UIColor { #colorLiteral(red: 0.003921568627, green: 0.2117647059, blue: 0.2941176471, alpha: 1) } //таббар #01364B
    static var accentLightBlue: UIColor { #colorLiteral(red: 0.03137254902, green: 0.3843137255, blue: 0.4470588235, alpha: 1) } // #086272

    static var accentDarkYellow: UIColor { #colorLiteral(red: 0.7176470588, green: 0.5647058824, blue: 0.1803921569, alpha: 1) } // не активная кнопка таббара #B7902E
    static var accentYellow: UIColor { #colorLiteral(red: 0.9921568627, green: 1, blue: 0.2823529412, alpha: 1) } //неактивная кнопка таббара #FDFF48
    static var accentLightYellow: UIColor { #colorLiteral(red: 0.7137254902, green: 0.6039215686, blue: 0.3254901961, alpha: 1) } // #B69A53
    
    static var accentDarkRed: UIColor { #colorLiteral(red: 0.3333333333, green: 0.06274509804, blue: 0, alpha: 1) } //кнопка добавить #551000
    static var accentRed: UIColor { #colorLiteral(red: 0.431372549, green: 0.08235294118, blue: 0, alpha: 1) } // #6E1500
    static var accentLightRed: UIColor { #colorLiteral(red: 0.7568627451, green: 0.3019607843, blue: 0.1882352941, alpha: 1) } //активная кнопка таббара #C14D30
}
