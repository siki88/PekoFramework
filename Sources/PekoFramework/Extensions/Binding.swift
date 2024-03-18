//
//  Binding.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
