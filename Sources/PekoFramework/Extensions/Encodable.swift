//
//  Encodable.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

public extension Encodable {
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    var convertToData: Data? {
        let jsonEncoder = JSONEncoder()
        do {
            return try jsonEncoder.encode(self)
        } catch {
            return nil
        }
    }
    
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return json
    }
}
