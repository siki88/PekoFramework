//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 19.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct PekoFrameworkModifier: ViewModifier {
    
    @State public var showToast: Toast? = nil
    @State public var showActivityIndicator: Bool = false
    @State public var showSharedActivityView: Bool = false
    
    public func body(content: Content) -> some View {
        content
            .toastView(showToast: $showToast)
            .activityIndicatorView(isVisible: $showActivityIndicator)
            .imagePicker()
            .pHPickerModifier()
            .sheet(isPresented: $showSharedActivityView) {
                let items: [Any] = PekoConfigurations.shared.itemsSharedActivityView ?? []
                let shareable: ShareableImage? = PekoConfigurations.shared.shareableImageSharedActivityView
                SharedActivityView(shareable: shareable, items: items, showing: $showSharedActivityView)
            }
            .onReceive(PekoConfigurations.shared.$showToast.dropFirst()) { showToast in
                self.showToast = showToast
            }
            .onReceive(PekoConfigurations.shared.$showActivityIndicator.dropFirst()) { showActivityIndicator in
                self.showActivityIndicator = showActivityIndicator
            }
            .onReceive(PekoConfigurations.shared.$showSharedActivityView.dropFirst()) { showSharedActivityView in
                self.showSharedActivityView = showSharedActivityView
            }
            .environmentObject(PekoConfigurations.shared)
    }
}

@available(iOS 16.4, *)
public extension View {
    func pekoFrameworkView() -> some View {
        self.modifier(PekoFrameworkModifier())
    }
}

