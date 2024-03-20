//
//  Array.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
    subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
}
