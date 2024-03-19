//
//  ActivityIndicatorView.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

// https://github.com/exyte/ActivityIndicatorView

/*
 USES:
 AnyView {
        }
        .activityIndicatorView(isVisible: $showActivityIndicator)
 */

import SwiftUI

@available(iOS 16.4, *)
public struct ActivityIndicatorView: View {

    public enum IndicatorType {
        case `default`(count: Int = 8)
    }

    @Binding var isVisible: Bool
    var color: Color = .red
    var type: IndicatorType

    public init(isVisible: Binding<Bool>, color: Color = .red, type: IndicatorType = .default()) {
        _isVisible = isVisible
        self.type = type
        self.color = color
    }

    public var body: some View {
        indicator
            .frame(width: 50, height: 50)
            .foregroundColor(color)
        /*
        if isVisible {
            indicator
                .frame(width: 50, height: 50)
                .foregroundColor(.ui.pink)
        } else {
            EmptyView()
        }
        */
    }
    
    // MARK: - Private
    
    private var indicator: some View {
        ZStack {
            switch type {
            case .default(let count):
                DefaultIndicatorView(count: count)
            }
        }
    }
}

@available(iOS 16.4, *)
struct DefaultIndicatorView: View {
    
    let count: Int
    
    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                DefaultIndicatorItemView(
                    index: index,
                    count: count,
                    size: geometry.size
                )
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }
}

@available(iOS 16.4, *)
struct DefaultIndicatorItemView: View {
    
    let index: Int
    let count: Int
    let size: CGSize
    
    @State private var opacity: Double = 0
    
    var body: some View {
        let height = size.height / 3.2
        let width = height / 2
        let angle = 2 * .pi / CGFloat(count) * CGFloat(index)
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)
        
        let animation = Animation.default
            .repeatForever(autoreverses: true)
            .delay(Double(index) / Double(count) / 2)
        
        return RoundedRectangle(cornerRadius: width / 2 + 1)
            .frame(width: width, height: height)
            .rotationEffect(Angle(radians: Double(angle + CGFloat.pi / 2)))
            .offset(x: x, y: y)
            .opacity(opacity)
            .onAppear {
                opacity = 1
                withAnimation(animation) {
                    opacity = 0.3
                }
            }
    }
}

@available(iOS 16.4, *)
struct ActivityIndicatorModifier: ViewModifier {
    
    public enum IndicatorType {
        case `default`(count: Int = 8)
    }
    
    @Binding var isVisible: Bool
    
    var type: IndicatorType = .default()
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainContentView()
                }
            )
    }
    
    @ViewBuilder func mainContentView() -> some View {
        if isVisible {
            indicator
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
        } else {
            EmptyView()
        }
    }
    
    private var indicator: some View {
        ZStack {
            switch type {
            case .default(let count):
                DefaultIndicatorView(count: count)
            }
        }
    }
}

@available(iOS 16.4, *)
public extension View {
    func activityIndicatorView(isVisible: Binding<Bool>) -> some View {
        self.modifier(ActivityIndicatorModifier(isVisible: isVisible))
    }
}

