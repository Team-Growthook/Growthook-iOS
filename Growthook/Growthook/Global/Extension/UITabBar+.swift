//
//  UITabBar+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UITabBar {
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
