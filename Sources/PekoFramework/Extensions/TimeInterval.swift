//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import Foundation

public extension TimeInterval {
    static func minutes(_ minutes: Int) -> Self {
        Double(minutes * 60)
    }
    
    static func hours(_ hours: Int) -> Self {
        minutes(hours * 60)
    }
    
    static func days(_ days: Int) -> Self {
        hours(days * 24)
    }
}
