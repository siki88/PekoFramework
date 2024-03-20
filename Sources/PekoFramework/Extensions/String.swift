//
//  String.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

@available(iOS 16.4, *)
public extension String {
    
    var toDouble: Double {
        (self as NSString).doubleValue
    }
    
    var toInt: Int {
        (self as NSString).integerValue
    }
    
    var toDoubleLocaleFormatter: String {
        self.toDouble.localeFormatter
    }
    
    var toUrl: URL? {
        URL(string: self)
    }
    
    func rounded(count: Int = 0) -> String {
        String(format: "%.\(count)f", self)
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func stringToDateFormatter(dateFormat: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
    func isEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
