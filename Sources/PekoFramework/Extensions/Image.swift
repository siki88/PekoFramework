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

public extension UIImage {
    // Convert UIImage to Data
    func toData(compress: CGFloat = 1.0, oldMethod: Bool = true) -> Data? {
        if oldMethod {
            return self.pngData() ?? self.jpegData(compressionQuality: compress) ?? self.heic
        } else {
            if #available(iOS 17, *) {
                return self.jpegData(compressionQuality: compress) ?? self.pngData() ?? self.heicData()
            } else {
                return self.jpegData(compressionQuality: compress) ?? self.pngData() ?? self.heic
            }
        }
    }
    
    // Calculate image's file size
    func fileSize() -> String {
        guard let imageData = self.toData() else { return "Unknown size" }
        let size = Double(imageData.count) // in bytes
        if size < 1024 {
            return String(format: "%.2f bytes", size)
        } else if size < 1024 * 1024 {
            return String(format: "%.2f KB", size/1024.0)
        } else {
            return String(format: "%.2f MB", size/(1024.0*1024.0))
        }
    }
    
    // Determine image's file type
    func fileType() -> String {
        guard let data = self.toData(), data.count > 8 else { return "unknown" }
        
        var header = [UInt8](repeating: 0, count: 8)
        data.copyBytes(to: &header, count: 8)
        
        switch header {
        case [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]: // PNG: 89 50 4E 47 0D 0A 1A 0A
            return "png"
        case [0xFF, 0xD8, 0xFF]: // JPEG: FF D8 FF
            return "jpg"
        default:
            return "unknown"
        }
    }
}
