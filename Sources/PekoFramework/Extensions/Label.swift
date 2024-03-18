//
//  Label.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
struct Label: View {
    var text: String
    var font: Font = Font.system(size: 15)
    var bold: Bool = false
    var color: Color = .white
    var alignment: Alignment = .leading
    var maxWidth: CGFloat? = .infinity
    
    var body: some View {
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
