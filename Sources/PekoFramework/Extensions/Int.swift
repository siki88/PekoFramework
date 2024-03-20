//
//  Int.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

public extension Int {
    var toString: String {
        "\(self)"
    }
    
    var toDouble: Double {
        return Double(self)
    }
}

public extension CGFloat {
    var toDouble: Double {
        return Double(self)
    }
}
