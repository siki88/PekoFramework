//
//  Error.swift
//
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import Foundation

public extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
