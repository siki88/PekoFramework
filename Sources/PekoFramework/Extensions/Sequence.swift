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
    
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }
    
    /// Sums up values of elements in self.
    public func sum<T: Numeric>(_ numerator: (Self.Iterator.Element) throws -> T) rethrows -> T {
        return try self.map(numerator).sum()
    }
    
    /// Sums up values of elements in self.
    public func sum(_ numerator: (Self.Iterator.Element) throws -> NSDecimalNumber) rethrows -> NSDecimalNumber {
        var result: NSDecimalNumber = NSDecimalNumber.zero
        for obj in self {
            result = try result.adding(numerator(obj))
        }
        return result
    }
}

@available(iOS 16.4, *)
public extension Sequence where Self.Iterator.Element : Numeric {
    
    /// Sums up itself.
    public func sum() -> Self.Iterator.Element {
        return self.reduce(0, +)
    }
}

