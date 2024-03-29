//
//  Color.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import UIKit.UIColor

public extension UIColor {
    convenience init<T: BinaryInteger>(r: T, g: T, b: T, a: T = 255) {
        self.init(red: .init(r)/255, green: .init(g)/255, blue: .init(b)/255, alpha: .init(a)/255)
    }
    convenience init<T: BinaryFloatingPoint>(r: T, g: T, b: T, a: T = 1.0) {
        self.init(red: .init(r), green: .init(g), blue: .init(b), alpha: .init(a))
    }
    
    /// Create color from a hex string (starting with #)..
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let chars = Array(hexString.dropFirst())
        self.init(
            red: .init(strtoul(String(chars[0 ... 1]), nil, 16)) / 255,
            green: .init(strtoul(String(chars[2 ... 3]), nil, 16)) / 255,
            blue: .init(strtoul(String(chars[4 ... 5]), nil, 16)) / 255,
            alpha: alpha
        )
    }
    
    var hexString: String {
        let components = cgColor.components
        let redComponent: CGFloat = components?[0] ?? 0.0
        let greenComponent: CGFloat = components?[1] ?? 0.0
        let blueComponent: CGFloat = components?[2] ?? 0.0
        
        return String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(redComponent * 255)),
            lroundf(Float(greenComponent * 255)),
            lroundf(Float(blueComponent * 255))
        )
    }
}
