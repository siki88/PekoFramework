//
//  Image.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI
import UIKit.UIImage

@available(iOS 16.4, *)
public extension Image {
    init?(data: Data?) {
        guard let data else { return nil }
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
    }
    
    func imageIconModifier(color: Color, size: CGFloat) -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(color)
            .frame(width: size, height: size)
    }
}

public extension UIImage {
    var heic: Data? { heic() }
    
    var cgImageOrientation: CGImagePropertyOrientation { .init(imageOrientation) }
    
    
    func heic(compressionQuality: CGFloat = 0.5) -> Data? {
        guard
            let mutableData = CFDataCreateMutable(nil, 0),
            let destination = CGImageDestinationCreateWithData(mutableData, "public.heic" as CFString, 1, nil),
            let cgImage = cgImage else {
            return nil
        }
        
        CGImageDestinationAddImage(
            destination,
            cgImage,
            [
                kCGImageDestinationLossyCompressionQuality: compressionQuality,
                kCGImagePropertyOrientation: cgImageOrientation.rawValue
            ] as CFDictionary)
        
        guard CGImageDestinationFinalize(destination) else { return nil }
        return mutableData as Data
    }
}

public extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
