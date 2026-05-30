//
//  String+Extensions.swift
//  Core
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Foundation

public extension String {
  func getYear() -> Int? {
    Int(split(separator: "-").first ?? "")
  }

  /// Converts a date string from a specific source format into a target formatted string.
  ///
  /// This extension provides a flexible way to parse and reformat date strings,
  /// handling explicit locales and time zones to avoid device-specific configuration issues.
  ///
  /// ### Example Usage:
  /// ```swift
  /// let apiDate = "2026-05-2019:41:43Z"
  ///
  /// // Uses default parameters (UTC input to "dd/MM/yyyy" output)
  /// let formatted = apiDate.toDate()
  /// print(formatted) // Output: Optional("20/05/2026")
  /// ```
  ///
  /// - Parameters:
  ///   - source: The expected date format of the current string. Defaults
  ///   to `"yyyy-MM-ddHH:mm:ssX"`.
  ///   - target: The desired output date format string. Defaults to `"dd/MM/yyyy"`.
  ///   - locale: The locale used to parse the initial string. Defaults to `"en_US_POSIX"`
  ///    to ensure stability against user device modifications.
  ///   - zone: The time zone of the incoming string. Defaults to UTC (`secondsFromGMT: 0`).
  ///   - useLocalTimeForOutput: A boolean indicating whether the output string should
  ///   shift to the user's current local time zone. Defaults to `false`.
  /// - Returns: A formatted date string if the parsing succeeds; otherwise, `nil`.
  func toDate(fromFormat source: String = "yyyy-MM-ddHH:mm:ssX",
              toFormat target: String = "dd/MM/yyyy",
              locale: Locale = Locale(identifier: "en_US_POSIX"),
              timeZone zone: TimeZone? = TimeZone(secondsFromGMT: 0),
              useLocalTimeForOutput: Bool = false) -> String? {
    let formatOutput = DateFormatter()
    formatOutput.dateFormat = source
    formatOutput.locale = locale
    formatOutput.timeZone = zone

    guard let objectDate = formatOutput.date(from: self) else {
      return nil
    }

    formatOutput.dateFormat = target
    formatOutput.timeZone = useLocalTimeForOutput ? TimeZone.current : zone

    return formatOutput.string(from: objectDate)
  }

  /// Converts an ISO 8601 string into a display string using the user's OS style preferences.
  ///
  /// This method guarantees absolute compliance with the user's device configuration,
  /// inheriting their locale, timezone, date style, and time style.
  ///
  /// - Parameters:
  ///   - dateStyle: The level of detail for the date (e.g., `.short`, `.medium`, `.long`). Defaults to `.short`.
  ///   - timeStyle: The level of detail for the time (e.g., `.none`, `.short`). Defaults to `.none`.
  /// - Returns: A localized string formatted according to the user's OS settings, or `nil` if parsing fails.
  func formatarDataISO(dateStyle: DateFormatter.Style = .short,
                       timeStyle: DateFormatter.Style = .none) -> String? {
    let isoFormatter = ISO8601DateFormatter()
    guard let objectDate = isoFormatter.date(from: self) else { return nil }

    let formatOutput = DateFormatter()
    formatOutput.locale = Locale.current
    formatOutput.timeZone = TimeZone.current
    formatOutput.dateStyle = dateStyle
    formatOutput.timeStyle = timeStyle

    return formatOutput.string(from: objectDate)
  }

  /// Converts an ISO 8601 formatted date string into a localized display string.
  ///
  /// This method automatically adapts the date and time format, language, and time zone
  /// based on the user's OS settings and device preferences.
  ///
  /// - Parameter template: A string template representing the components you want to
  /// display (e.g., `"ddMMyyyy"` or `"ddMMyyyyHHmm"`).
  ///   The OS will automatically rearrange these components to match the user's regional
  ///   settings. Defaults to `"dd/MM/yyyy"`.
  /// - Returns: A localized, formatted string representation of the date, or `nil` if parsing fails.
  func formatDateISO(template: String = "dd/MM/yyyy") -> String? {
    let isoFormatter = ISO8601DateFormatter()
    guard let objectDate = isoFormatter.date(from: self) else { return nil }

    let formatOutput = DateFormatter()
    formatOutput.locale = Locale.current
    formatOutput.timeZone = TimeZone.current

    formatOutput.setLocalizedDateFormatFromTemplate(template)

    return formatOutput.string(from: objectDate)
  }
}
