//
//  Application.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import UIKit

@available(iOS 16.4, *)
public extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    var key: UIWindow? {
        self.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?
            .windows
            .filter({$0.isKeyWindow})
            .first
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        get {
            UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.rootViewController?.overrideUserInterfaceStyle ?? UIScreen.main.traitCollection.userInterfaceStyle
        }
        set {
            UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.rootViewController?.overrideUserInterfaceStyle = newValue
        }
    }
    
    var safeAreaInsets: UIEdgeInsets? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?
            .safeAreaInsets
    }
}
