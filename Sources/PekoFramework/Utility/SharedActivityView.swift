//
//  SharedActivityView.swift
//
//
//  Created by Lukáš Spurný on 19.03.2024.
//

import SwiftUI
import LinkPresentation

@available(iOS 16.4, *)
public struct SharedActivityView: UIViewControllerRepresentable {
    
    var shareable: ShareableImage?
    var items: [Any]
    @Binding var showing: Bool
    
    public init(
        shareable: ShareableImage?,
        items: [Any],
        showing: Binding<Bool>
    ) {
        self.shareable = shareable
        self.items = items
        self._showing = showing
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        var items: [Any] = self.items
        if let shareable {
            items = [shareable]
        }
        
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

public final class ShareableImage: NSObject, UIActivityItemSource {
    
    private let image: UIImage
    private let title: String

    public init(image: UIImage, title: String) {
        self.image = image
        self.title = title
        super.init()
    }

    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return image
    }

    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return image
    }
    
    public func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.iconProvider = NSItemProvider(object: image)
        metadata.title = title
        let size = image.fileSize()
        let type = image.fileType()
        let subtitleString = "\(type.uppercased()) File · \(size)"
        metadata.originalURL = URL(fileURLWithPath: subtitleString)
        return metadata
    }

}
