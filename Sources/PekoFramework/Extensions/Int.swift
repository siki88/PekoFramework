//
//  Int.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

@available(iOS 16.4, *)
public extension Int {
    var toString: String {
        "\(self)"
    }
    
    var toDouble: Double {
        return Double(self)
    }
    
    var toDoubleLocaleFormatter: String {
        "\(self)".toDouble.localeFormatter
    }
}

@available(iOS 16.4, *)
public extension CGFloat {
    var toDouble: Double {
        return Double(self)
    }
}
