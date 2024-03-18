//
//  Text.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
extension Text {
    init<S>(_ text: S) where S : StringProtocol {
        let text = String(text)
        let translated = PekoConfigurations.shared.localizable(text)
        self.init(verbatim: translated)
    }
    
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        let translated = PekoConfigurations.shared.localizable(string)
        var attributedString = AttributedString(translated)
        configure(&attributedString)
        self.init(attributedString)
    }
}
