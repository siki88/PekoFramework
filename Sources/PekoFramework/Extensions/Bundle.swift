//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import Foundation

public extension Bundle {
    var appName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildNumber: String? {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}

