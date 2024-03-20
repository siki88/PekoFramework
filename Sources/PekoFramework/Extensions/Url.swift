//
//  Url.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

public extension URL {
    func findValueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
