//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import Combine
import Foundation

public extension Publisher {
    func sink(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: receiveCompletion, receiveValue: { _ in })
    }
    
    func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: receiveValue)
    }
}
