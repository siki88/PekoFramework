//
//  FloatingLsbelTextField.swift
//  
//
//  Created by Lukáš Spurný on 21.03.2024.
//

import SwiftUI

//https://github.com/reddavis/FloatingLabelTextFieldStyle

@available(iOS 16.4, *)
struct FloatingLabelTextField: View {
    @Binding var text: String
    let textField: TextField<TextFieldStyle._Label>
    let defaultBorderColor: Color
    let backgroundColor: Color
    let showClearButton: Bool
    let showEyeButton: Bool
    let showPassword: Bool
    let title: FloatingLabelTextFieldStyle.TitleStyle
    let error: FloatingLabelTextFieldStyle.ErrorStyle?
    var eyeTapped: ((Bool) -> ())?
    
    // Private
    @State private var isHighlighted: Bool = false
    @FocusState private var isTextFieldFocussed: Bool
    
    private var isTextFieldHidden: Bool {
        if self.isHighlighted { return false }
        return self.text.isEmpty
    }
    
    private var borderColor: Color {
        if let error = self.error {
            return error.color
        }
        
        if self.isHighlighted || !self.text.isEmpty {
            return self.title.floatingColor
        } else {
            return self.defaultBorderColor
        }
    }
    
    private var borderWidth: Double {
        if self.isHighlighted && !self.text.isEmpty && self.error != nil {
            return 2.0
        } else {
            return 1.0
        }
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                textInput()
                if self.showClearButton {
                    clearButton()
                } else if self.showEyeButton {
                    Spacer()
                    eyeButton()
                } else {
                    Spacer()
                }
            }
            
            if let error = self.error {
                Text(error.text)
                    .font(error.font)
                    .foregroundColor(error.color)
            }
        }
        .contentShape(Rectangle())
        .padding(
            self.isTextFieldHidden ? EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            : EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        )
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.backgroundColor)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(
                    isHighlighted ? borderColor : Color.black,
                    lineWidth: self.borderWidth
                )
        )
        .onTapGesture {
            guard self.isTextFieldHidden else { return }
            self.isHighlighted = true
        }
        .onChange(of: self.isHighlighted) { newValue in
            guard self.isHighlighted else { return }
            
            Task {
                // Required or text field doesn't actually receive focus...
                try? await Task.sleep(nanoseconds: 1_000_000_000 / 6)
                self.isTextFieldFocussed = newValue
            }
        }
        .onChange(of: self.isTextFieldFocussed) { newValue in
            self.isHighlighted = self.isTextFieldFocussed
        }
    }
    
    // MARK: UI
    
    private func textInput() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.title.text)
                .font(self.isTextFieldHidden ? .body : .footnote)
                .foregroundColor(self.isTextFieldHidden ? self.title.color : self.title.floatingColor)
                .animation(.easeInOut(duration: 0.2), value: self.isTextFieldHidden)
            
            self.textField
                .foregroundColor(Color.primary)
                .focused(self.$isTextFieldFocussed, equals: true)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                .isHidden(self.isTextFieldHidden, remove: true)
        }
    }
    
    private func clearButton() -> some View {
        Group {
            if self.text.isEmpty {
                Spacer()
            } else {
                Button(
                    action: { self.text.removeAll() },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                )
            }
        }
    }
    
    private func eyeButton() -> some View {
        Button {
            eyeTapped?(showPassword)
        } label: {
            Image(showPassword ? "eyeDisable" : "eyeEnable")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
                .frame(height: 22)
        }
    }
}

/// A floating label style for `TextField` with support for displaying
/// error messages.

@available(iOS 16.4, *)
public struct FloatingLabelTextFieldStyle: TextFieldStyle {
    private let borderColor: Color
    private let backgroundColor: Color
    private let titleStyle: FloatingLabelTextFieldStyle.TitleStyle
    private let errorStyle: FloatingLabelTextFieldStyle.ErrorStyle?
    private let showClearButton: Bool
    private let showEyeButton: Bool
    private let showPassword: Bool
    private var eyeTapped: ((Bool) -> ())?
    
    // MARK: Initialization
    
    /// Initialize a new `FloatingLabelTextFieldStyle` instance.
    /// - Parameters:
    ///   - borderColor: The default border colour.
    ///   - backgroundColor: The background colour.
    ///   - showClearButton: Indicate whether to display clear text button.
    ///   - titleStyle: The title style.
    ///   - errorStyle: The error style.
    public init(
        borderColor: Color,
        backgroundColor: Color,
        showClearButton: Bool = true,
        showEyeButton: Bool = false,
        showPassword: Bool = false,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil,
        eyeTapped: ((Bool) -> ())?
    ) {
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.titleStyle = titleStyle
        self.errorStyle = errorStyle
        self.showClearButton = showClearButton
        self.showEyeButton = showEyeButton
        self.showPassword = showPassword
        self.eyeTapped = eyeTapped
    }
    
    // MARK: TextFieldStyle
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        let mirror = Mirror(reflecting: configuration)
        let text = mirror.descendant("_text") as! Binding<String>
        
        FloatingLabelTextField(
            text: text,
            textField: configuration,
            defaultBorderColor: self.borderColor,
            backgroundColor: self.backgroundColor,
            showClearButton: self.showClearButton,
            showEyeButton: self.showEyeButton,
            showPassword: self.showPassword,
            title: self.titleStyle,
            error: self.errorStyle,
            eyeTapped: self.eyeTapped
        )
    }
}

// MARK: Dot helper

@available(iOS 16.4, *)
extension TextFieldStyle where Self == FloatingLabelTextFieldStyle {
    /// A text field style with floating label decoration.
    public static func floating(
        borderColor: Color = .black.opacity(0.1),
        backgroundColor: Color = .clear,
        showClearButton: Bool = true,
        showEyeButton: Bool = false,
        showPassword: Bool = false,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil,
        eyeTapped: ((Bool) -> ())? = nil
    ) -> Self {
        .init(
            borderColor: borderColor,
            backgroundColor: backgroundColor,
            showClearButton: showClearButton,
            showEyeButton: showEyeButton,
            showPassword: showPassword,
            titleStyle: titleStyle,
            errorStyle: errorStyle,
            eyeTapped: eyeTapped
        )
    }
}

@available(iOS 16.4, *)
public extension FloatingLabelTextFieldStyle {
    /// Floating label text field style error configuration.
    struct ErrorStyle
    {
        /// The error text.
        let text: String
        
        /// The font of the error text.
        let font: Font
        
        /// The color of the error text.
        /// This color will also be used to style the border.
        let color: Color
        
        // MARK: Initialization
        
        /// Initialize a new `FloatingLabelTextFieldStyle.Error` instance.
        /// - Parameters:
        ///   - text: The error text.
        ///   - font: The error font.
        ///   - color: The error color.
        public init(
            text: String,
            font: Font = .footnote,
            color: Color = .red
        )
        {
            self.text = text
            self.font = font
            self.color = color
        }
    }
}

@available(iOS 16.4, *)
public extension FloatingLabelTextFieldStyle {
    /// Floating label text field style title configuration.
    struct TitleStyle
    {
        /// The title's text.
        let text: String
        
        /// The title's font.
        let font: Font
        
        /// The title's font when the text field is highlighted.
        let floatingFont: Font
        
        /// The title's color.
        let color: Color
        
        /// The title's color when the text field is highlighted.
        let floatingColor: Color
        
        // MARK: Initialization
        
        /// Initialize a new `FloatingLabelTextFieldStyle.Title` instance.
        /// - Parameters:
        ///   - text: The text.
        ///   - font: The font.
        ///   - floatingFont: The font when highlighted.
        ///   - color: The color.
        ///   - floatingColor: The color when highlighted.
        public init(
            text: String,
            font: Font = .body,
            floatingFont: Font = .footnote,
            color: Color = .gray,
            floatingColor: Color = .accentColor
        )
        {
            self.text = text
            self.font = font
            self.floatingFont = floatingFont
            self.color = color
            self.floatingColor = floatingColor
        }
    }
}
