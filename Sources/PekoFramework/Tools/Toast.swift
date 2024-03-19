//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 18.03.2024.
//

//https://ondrej-kvasnovsky.medium.com/how-to-build-a-simple-toast-message-view-in-swiftui-b2e982340bd

/*
 USES:
 AnyView {
        }
        .toastView(showToast: $showToast)
 */

import SwiftUI

public struct Toast: Equatable {
    
    public init(
        style: ToastStyle,
        message: String,
        duration: Double = 5,
        width: Double = .infinity
    ) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
    }
    
    var style: ToastStyle
    var message: String
    var duration: Double = 5
    var width: Double = .infinity
}

public enum ToastStyle {
    case error
    case warning
    case success
    case info
}

@available(iOS 16.4, *)
public extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

@available(iOS 16.4, *)
public struct ToastView: View {
    
    public var style: ToastStyle
    public var message: String
    public var width = CGFloat.infinity
    public var onCancelTapped: (() -> Void)
    
    private var osTheme: UIUserInterfaceStyle {
        UIApplication.shared.userInterfaceStyle
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .font(Font.caption)
                .foregroundColor(Color.black)
                //.foregroundColor(osTheme == .light ? Color.black : Color.white)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
            //.stroke(style.themeColor, lineWidth: 0.5)
                .stroke(style.themeColor, lineWidth: 1)
                .opacity(0.6)
            //.glow(color: style.themeColor, radius: 4)
        )
        .padding(.horizontal, 16)
    }
}

@available(iOS 16.4, *)
public struct ToastModifier: ViewModifier {
    
    @Binding public var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: 32)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(
                    style: toast.style,
                    message: toast.message,
                    width: toast.width
                ) {
                    dismissToast()
                }
                Spacer()
            }
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

@available(iOS 16.4, *)
public extension View {
    func toastView(showToast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: showToast))
    }
}
