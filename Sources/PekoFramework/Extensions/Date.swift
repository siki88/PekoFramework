//
//  Date.swift
//  
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

extension Date {
    func dateToStringFormatter(_ dateFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    func isTheSameDay(as otherDate: Date) -> Bool {
        let components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: self
        )
        let otherComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: otherDate
        )
        return components.year == otherComponents.year &&
        components.month == otherComponents.month &&
        components.day == otherComponents.day
    }
    
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}
