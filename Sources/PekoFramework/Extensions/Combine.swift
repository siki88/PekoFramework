//
//  Combine.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation
import Combine

@available(iOS 16.4, *)
struct ZipMany<Element, Failure>: Publisher where Failure: Error {
    typealias Output = [Element]

    private let underlying: AnyPublisher<Output, Failure>

    init<T: Publisher>(publishers: [T]) where T.Output == Element, T.Failure == Failure {
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

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        underlying.receive(subscriber: subscriber)
    }
}
