//
//  Date+Extensions.swift
//  Core
//
//  Created by Tiago de Oliveira on 30/05/26.
//

import Foundation

extension Date {
    /// Converts a Date object into a formatted string based on specified configurations.
    ///
    /// This extension allows quick and robust conversion of Date objects into strings for API payloads
    /// or localized UI display, ensuring consistent formatting regardless of user device settings.
    ///
    /// ### Example Usage:
    /// ```swift
    /// let today = Date()
    ///
    /// // Converts to API format in UTC (default)
    /// let apiString = today.toString()
    /// print(apiString) // Output: Optional("2026-05-3014:54:23Z")
    ///
    /// // Converts to Brazilian format using the device's time zone
    /// let uiString = today.toString(toFormat: "dd/MM/yyyy", timeZone: .current)
    /// print(uiString) // Output: Optional("30/05/2026")
    /// ```
    ///
    /// - Parameters:
    ///   - target: The desired output date format string. Defaults to `"yyyy-MM-ddHH:mm:ssX"`.
    ///   - locale: The locale used to generate the output string. Defaults to `"en_US_POSIX"` to prevent unexpected 12h/24h system overrides.
    ///   - zone: The target time zone for the output string. Defaults to UTC (`secondsFromGMT: 0`), which is ideal for API communications.
    /// - Returns: A formatted date string if the conversion succeeds; otherwise, `nil`.
    func toString(toFormat target: String = "yyyy-MM-ddHH:mm:ssX",
                  locale: Locale = Locale(identifier: "en_US_POSIX"),
                  timeZone zone: TimeZone? = TimeZone(secondsFromGMT: 0)) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = target
        formatter.locale = locale
        formatter.timeZone = zone
        return formatter.string(from: self)
    }
}
