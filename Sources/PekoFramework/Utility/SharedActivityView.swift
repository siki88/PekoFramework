//
//  SharedActivityView.swift
//
//
//  Created by Lukáš Spurný on 19.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct SharedActivityView: UIViewControllerRepresentable {
    
    var items: [Any]
    @Binding var showing: Bool
    
    public init(
        items: [Any],
        showing: Binding<Bool>
    ) {
        self.items = items
        self._showing = showing
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        vc.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            self.showing = false
        }
        return vc
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
