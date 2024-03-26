//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 26.03.2024.
//

import UIKit

extension Float {
    func toStringFormat(to places: Int = 0) -> String {
        String(format: "%.0\(places)f", self)
    }
}
