//
//  Double.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

@available(iOS 16.4, *)
extension Double {
    var toInt: Int {
        Int(self)
    }
    
    var toString: String {
        "\(self)"
    }
    
    var localeFormatter: String {
        self.formatted(.number.locale(.init(identifier: "cs_CZ")))
    }
    
    var toDoubleLocaleFormatter: String {
        "\(Int(self))".toDouble.localeFormatter
    }
}

extension Optional where Wrapped == Double {
    var toString: String {
        guard let value = self else { return "" }
        return "\(value)"
    }
}

extension Optional where Wrapped == Int {
    var toString: String {
        guard let value = self else { return "" }
        return "\(value)"
    }
}

extension Decimal {
    var toDouble: Double {
        Double(truncating: self as NSNumber)
    }
}
