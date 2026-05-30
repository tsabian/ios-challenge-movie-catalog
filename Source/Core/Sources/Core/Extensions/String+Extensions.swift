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
  ///   - source: The expected date format of the current string. Defaults to `"yyyy-MM-ddHH:mm:ssX"`.
  ///   - target: The desired output date format string. Defaults to `"dd/MM/yyyy"`.
  ///   - locale: The locale used to parse the initial string. Defaults to `"en_US_POSIX"` to ensure stability against user device modifications.
  ///   - zone: The time zone of the incoming string. Defaults to UTC (`secondsFromGMT: 0`).
  ///   - useLocalTimeForOutput: A boolean indicating whether the output string should shift to the user's current local time zone. Defaults to `false`.
  /// - Returns: A formatted date string if the parsing succeeds; otherwise, `nil`.
  func toDate(fromFormat source: String = "yyyy-MM-ddHH:mm:ssX",
              toFormat target: String = "dd/MM/yyyy",
              locale: Locale = Locale(identifier: "en_US_POSIX"),
              timeZone zone: TimeZone? = TimeZone(secondsFromGMT: 0),
              useLocalTimeForOutput: Bool = false) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = source
    formatter.locale = locale
    formatter.timeZone = zone

    guard let dateObject = formatter.date(from: self) else {
      return nil
    }

    formatter.dateFormat = target
    formatter.timeZone = useLocalTimeForOutput ? TimeZone.current : zone

    return formatter.string(from: dateObject)
  }
}
