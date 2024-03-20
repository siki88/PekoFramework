//
//  Sequence.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

@available(iOS 16.4, *)
public extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }
}
