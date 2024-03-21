//
//  CustomTextField.swift
//
//
//  Created by Lukáš Spurný on 21.03.2024.
//

import SwiftUI

public enum TypeCustomTextField {
    case basic
    case email
    case password
}

@available(iOS 16.4, *)
public struct CustomTextField: View {
    
    @State var typeCustomTextField: TypeCustomTextField
    @State var placeholder: String
    @State var axis: Axis = .horizontal
    @State var showPassword: Bool = false
    @State var disableTextField: Bool = false
    
    @Binding var text: String
    
    @FocusState var depositIsFocused: Bool
    
    
    
    /*
    @State var textFieldStyle: FloatingLabelTextFieldStyle = .init(
        borderColor: .black,
        backgroundColor: .black,
        titleStyle: .init(
            text: "",
            font: .system(size: 15),
            floatingFont: .system(size: 12),
            color: .black,
            floatingColor: .gray
        ),
        eyeTapped: nil
    )
     
    */
    
    @State var borderColor: Color = PekoConfigurations.shared.floatingLabelTextFieldBorderColor
    @State var floatingTitleStyle: FloatingLabelTextFieldStyle.TitleStyle = PekoConfigurations.shared.floatingLabelTextFieldStyle
    
    /*
    @State var borderColor: Color = .black
    @State var floatingTitleStyle: FloatingLabelTextFieldStyle.TitleStyle = .init(
        text: "",
        font: .system(size: 15),
        floatingFont: .system(size: 12),
        color: .black,
        floatingColor: .gray
    )
    */
    
    public init(
        typeCustomTextField: TypeCustomTextField,
        placeholder: String,
        axis: Axis = .horizontal,
        showPassword: Bool = false,
        disableTextField: Bool = false,
        text: Binding<String>,
        depositIsFocused: FocusState<Bool>
    ) {
        self.typeCustomTextField = typeCustomTextField
        self.placeholder = placeholder
        self.axis = axis
        self.showPassword = showPassword
        self.disableTextField = disableTextField
        self._text = text
        self._depositIsFocused = depositIsFocused
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            switch typeCustomTextField {
            case .basic:
                TextField("", text: $text, axis: axis)
                    .textFieldStyle(
                        .floating(
                            borderColor: borderColor,
                            titleStyle: .init(
                                text: placeholder,
                                font: floatingTitleStyle.font,
                                floatingFont: floatingTitleStyle.floatingFont,
                                color: floatingTitleStyle.color,
                                floatingColor: floatingTitleStyle.floatingColor
                            )
                        )
                    )
                    .keyboardType(.default)
                    .padding(.vertical, 4)
            case .email:
                TextField("", text: $text)
                    .textFieldStyle(
                        .floating(
                            borderColor: borderColor,
                            titleStyle: .init(
                                text: placeholder,
                                font: floatingTitleStyle.font,
                                floatingFont: floatingTitleStyle.floatingFont,
                                color: floatingTitleStyle.color,
                                floatingColor: floatingTitleStyle.floatingColor
                            )
                        )
                    )
                .keyboardType(.emailAddress)
                .padding(.vertical, 4)
            case .password:
                HStack {
                    if showPassword {
                        TextField("", text: $text)
                            .textFieldStyle(
                                .floating(
                                    borderColor: borderColor,
                                    showClearButton: false,
                                    showEyeButton: true,
                                    showPassword: showPassword,
                                    titleStyle: .init(
                                        text: placeholder,
                                        font: floatingTitleStyle.font,
                                        floatingFont: floatingTitleStyle.floatingFont,
                                        color: floatingTitleStyle.color,
                                        floatingColor: floatingTitleStyle.floatingColor
                                    ),
                                    eyeTapped: { value in
                                        showPassword = !value
                                    }
                                )
                            )
                    } else {
                        SecureField("", text: $text)
                            .textFieldStyle(
                                .floating(
                                    borderColor: borderColor,
                                    showClearButton: false,
                                    showEyeButton: true,
                                    showPassword: showPassword,
                                    titleStyle: .init(
                                        text: placeholder,
                                        font: floatingTitleStyle.font,
                                        floatingFont: floatingTitleStyle.floatingFont,
                                        color: floatingTitleStyle.color,
                                        floatingColor: floatingTitleStyle.floatingColor
                                    ),
                                    eyeTapped: { value in
                                        showPassword = !value
                                    }
                                )
                            )
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .disabled(disableTextField)
        .focused($depositIsFocused)
    }
    
    private func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}
