//
//  Combine.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation
import Combine

@available(iOS 16.4, *)
public struct ZipMany<Element, Failure>: Publisher where Failure: Error {
    public typealias Output = [Element]
    
    private let underlying: AnyPublisher<Output, Failure>
    
    public init<T: Publisher>(publishers: [T]) where T.Output == Element, T.Failure == Failure {
        let zipped: AnyPublisher<[T.Output], T.Failure>? = publishers.reduce(nil) { result, publisher in
            if let result = result {
                return publisher.zip(result).map { element, array in
                    array + [element]
                }.eraseToAnyPublisher()
            } else {
                return publisher.map { [$0] }.eraseToAnyPublisher()
            }
        }
        underlying = zipped ?? Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        underlying.receive(subscriber: subscriber)
    }
}

@available(iOS 16.4, *)
public class PublishedValue<T>: ObservableObject {
    @Published public  var value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func set(_ value: T) {
        self.value = value
    }
}
