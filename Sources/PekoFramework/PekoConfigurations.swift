//
//  PekoConfigurations.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import SwiftUI
import Wormholy

@available(iOS 16.4, *)
public class PekoConfigurations: ObservableObject {
    
    public static var shared = PekoConfigurations()
    
    public init() {
        #if DEBUG
            Wormholy.awake()
        #endif
    }
    
    // MARK: Toast
    @Published public var showToast: Toast? = nil
    
    // MARK: Activity indicator
    @Published public var colorActivityIndicator: Color = .red
    @Published public var showActivityIndicator: Bool = false
    
    // MARK: Shared
    @Published public var showSharedActivityView: Bool = false
    @Published public var itemsSharedActivityView: [Any]? = nil
    
    // MARK: Image picker
    @Published public var showImagePickerActionSheet: Bool = false
    @Published public var showImagePicker: Bool = false
    @Published public var selectedImage: UIImage? = nil
    @Published public var selectedSourceCamera: UIImagePickerController.SourceType = .camera
    
    // MARK: PHPicker
    @Published public var selectionLimitPHPicker: Int = 1
    @Published public var showPHPicker: Bool = false
    @Published public var selectedImages: [UIImage]? = nil
    
    // MARK: For implement localization text
    let identifier = Locale.current.language.languageCode?.identifier == "cs" || Locale.current.language.languageCode?.identifier == "sk" ? "cs" : "en"
    public func localizable(_ text: String) -> String {
        guard let path = Bundle.main.path(forResource: identifier, ofType: "lproj"),
              let bundle = Bundle(path: path)else {
            return ""
        }
        return NSLocalizedString(
            text,
            tableName: "Localizable",
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}
