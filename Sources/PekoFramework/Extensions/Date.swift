//
//  Date.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation

public extension Date {
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
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func addingDays(_ numberOfDaysAdded: Int) -> Date {
        let dateComponents = DateComponents(day: numberOfDaysAdded)
        return Calendar.current.date(
            byAdding: dateComponents,
            to: self
        )!
    }
    
    func addingMonths(_ numberOfMonthsAdded: Int) -> Date {
        let dateComponents = DateComponents(month: numberOfMonthsAdded)
        return Calendar.current.date(
            byAdding: dateComponents,
            to: self
        )!
    }
    
    var firstDayOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    var firstDayOfDay: Date {
        let components = Calendar.current.dateComponents([.day, .year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    var dateToTime: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        return "\(hour):\(String(format: "%02d", minutes))"
    }
}
