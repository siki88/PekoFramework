//
//  Label.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public struct Label: View {
    public var text: String
    public var font: Font = Font.system(size: 15)
    public var bold: Bool = false
    public var color: Color = .white
    public var alignment: Alignment = .leading
    public var maxWidth: CGFloat? = .infinity
    
    public var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(color)
            .bold(bold)
            .frame(maxWidth: maxWidth, alignment: alignment)
    }
    
    /*
     .multilineTextAlignment(.center)
     .lineLimit(nil)
     multiline:
     .fixedSize(horizontal: false, vertical: true)
     */
}
