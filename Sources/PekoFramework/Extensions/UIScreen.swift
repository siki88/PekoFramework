//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import UIKit

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static var isiPhoneSESizeOrSmaller: Bool {
        UIScreen.main.bounds.height <= 568
    }
    
    static var isiPhone8SizeOrSmaller: Bool {
        UIScreen.main.bounds.height <= 667
    }
    
    static var isiPhone8PlusSizeOrSmaller: Bool {
        UIScreen.main.bounds.height <= 736
    }
    
    static var isiPhoneXSizeOrSmaller: Bool {
        UIScreen.main.bounds.height <= 812
    }
}
