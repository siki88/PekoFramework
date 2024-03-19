//
//  PekoConfigurations.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

@available(iOS 16.4, *)
public class PekoConfigurations: ObservableObject {
    
    public static var shared = PekoConfigurations()
    
    public init() {}
    
    @Published public var showToast: Toast? = nil
    @Published public var showActivityIndicator: Bool = false
    
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
