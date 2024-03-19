//
//  SafeAreaInsets.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero).insets
    }
}

@available(iOS 16.4, *)
public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

@available(iOS 16.4, *)
private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
