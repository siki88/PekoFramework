//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import SwiftUI

public struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

public struct DetectOrientation: ViewModifier {
    
    @Binding var orientation: UIDeviceOrientation
    
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                orientation = UIDevice.current.orientation
            }
    }
}

// A View wrapper to make the modifier easier to use
public extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
    
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View {
        modifier(DetectOrientation(orientation: orientation))
    }
}
