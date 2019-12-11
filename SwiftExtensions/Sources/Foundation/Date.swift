//
//  FNDate.swift
//
//  Created by Steven Syp on 7/22/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import Foundation

/// Extends Foundation's `Date` class with usefull capabilities.
extension Date {

    /// Returns the first day of the current year.
    static func startOfYear(of date: Date = Date()) -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: date)
        components.day = 1
        components.month = 1
        return Calendar.current.date(from: components)!
    }


    /// Converts the date into a usable string.
    /// - Parameters:
    ///   - format: Date format (default: `MM/dd/yyyy`)
    ///   - style: Date Style (default: `long`)
    func toString(format: String = "MM/dd/yyyy", style: DateFormatter.Style = .long) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
