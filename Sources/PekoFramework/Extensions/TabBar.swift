//
//  TabBar.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//  

import UIKit

@available(iOS 16.4, *)
public struct TabBarModifier {
    public static func showTabBar() {
        UIApplication.shared.key?.allSubviews().forEach({ subView in
            if let view = subView as? UITabBar {
                view.isHidden = false
            }
        })
    }
    
    public static func hideTabBar() {
        UIApplication.shared.key?.allSubviews().forEach({ subView in
            if let view = subView as? UITabBar {
                view.isHidden = true
            }
        })
    }
}

