//
//  View.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

#if canImport(UIKit)
@available(iOS 16.4, *)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif

@available(iOS 16.4, *)
public extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove { self.hidden() }
        } else {
            self
        }
    }
    
    @ViewBuilder
    func safeOverlay<V: View>(alignment: Alignment, @ViewBuilder content: () -> V) -> some View {
        overlay(alignment: alignment, content: content)
        /*
         if #available(iOS 16.0, *) {
         overlay(alignment: alignment, content: content)
         } else {
         overlay(content(), alignment: alignment)
         }
         */
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func safeContentTransition() -> some View {
        if #available(iOS 17, *) {
            return self.contentTransition(.symbolEffect(.replace))
        }
        return self
    }
}

public extension UIView {
    func allSubviews() -> [UIView] {
        var subs = self.subviews
        for subview in self.subviews {
            let rec = subview.allSubviews()
            subs.append(contentsOf: rec)
        }
        return subs
    }
    
    func addFillingSubview(_ subview: UIView, edgeInsets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        activateFillingConstraints(on: subview, edgeInsets: edgeInsets)
    }
    
    func activateFillingConstraints(on subview: UIView, edgeInsets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeInsets.left),
            subview.rightAnchor.constraint(equalTo: rightAnchor, constant: edgeInsets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom)
        ])
    }
    
    func activateFillingConstraints(on layoutGuide: UILayoutGuide, edgeInsets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: edgeInsets.top),
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: edgeInsets.left),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: edgeInsets.right),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: edgeInsets.bottom)
        ])
    }
    
    static func makeSpacer(space: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: space).isActive = true
        return view
    }
}
