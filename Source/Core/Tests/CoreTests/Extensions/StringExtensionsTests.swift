//
//  StringExtensionsTests.swift
//  Core
//
//  Created by Tiago de Oliveira on 30/05/26.
//

@testable import Core
import Foundation
import Testing

struct StringExtensionsTests {
  @Test
  func getYearWhenStringStartsWithYearReturnsYear() {
    let result = "2026-05-20".getYear()

    #expect(result == 2026)
  }

  @Test
  func getYearWhenStringDoesNotStartWithNumberReturnsNil() {
    let result = "release-2026-05-20".getYear()

    #expect(result == nil)
  }

  @Test
  func getYearWhenStringIsEmptyReturnsNil() {
    let result = "".getYear()

    #expect(result == nil)
  }

  @Test
  func toDateWhenUsingDefaultFormatsReturnsFormattedDate() {
    let result = "2026-05-2019:41:43Z".toDate()

    #expect(result == "20/05/2026")
  }

  @Test
  func toDateWhenSourceFormatDoesNotMatchReturnsNil() {
    let result = "2026-05-20T19:41:43Z".toDate()

    #expect(result == nil)
  }

  @Test
  func toDateWhenUsingCustomFormatsReturnsFormattedDate() {
    let result = "2026-05-20".toDate(
      fromFormat: "yyyy-MM-dd",
      toFormat: "yyyy",
      timeZone: TimeZone(secondsFromGMT: 0)
    )

    #expect(result == "2026")
  }

  @Test
  func toDateWhenUsingLocalTimeForOutputReturnsDateInCurrentTimeZone() throws {
    let input = "2026-05-20T00:30:00Z"
    let result = input.toDate(
      fromFormat: "yyyy-MM-dd'T'HH:mm:ssX",
      toFormat: "yyyy-MM-dd HH:mm",
      timeZone: TimeZone(secondsFromGMT: 0),
      useLocalTimeForOutput: true
    )

    let expected = try makeFormattedDate(
      input,
      sourceFormat: "yyyy-MM-dd'T'HH:mm:ssX",
      targetFormat: "yyyy-MM-dd HH:mm",
      inputTimeZone: TimeZone(secondsFromGMT: 0),
      outputTimeZone: TimeZone.current
    )

    #expect(result == expected)
  }

  @Test
  func formatarDataISOWhenStringIsValidReturnsLocalizedDate() throws {
    let input = "2026-05-20T19:41:43Z"
    let result = input.formatarDataISO(dateStyle: .medium, timeStyle: .short)
    let expected = try makeLocalizedISODate(input, dateStyle: .medium, timeStyle: .short)

    #expect(result == expected)
  }

  @Test
  func formatarDataISOWhenStringIsInvalidReturnsNil() {
    let result = "not-a-date".formatarDataISO()

    #expect(result == nil)
  }

  @Test
  func formatDateISOWhenStringIsValidReturnsLocalizedDateUsingDefaultTemplate() throws {
    let input = "2026-05-20T19:41:43Z"
    let result = input.formatDateISO()
    let expected = try makeLocalizedISODate(input, template: "dd/MM/yyyy")

    #expect(result == expected)
  }

  @Test
  func formatDateISOWhenUsingCustomTemplateReturnsLocalizedDateAndTime() throws {
    let input = "2026-05-20T19:41:43Z"
    let template = "ddMMyyyyHHmm"
    let result = input.formatDateISO(template: template)
    let expected = try makeLocalizedISODate(input, template: template)

    #expect(result == expected)
  }

  @Test
  func formatDateISOWhenStringIsInvalidReturnsNil() {
    let result = "not-a-date".formatDateISO()

    #expect(result == nil)
  }

  private func makeFormattedDate(
    _ input: String,
    sourceFormat: String,
    targetFormat: String,
    inputTimeZone: TimeZone?,
    outputTimeZone: TimeZone?
  ) throws -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = sourceFormat
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = inputTimeZone

    guard let date = formatter.date(from: input) else {
      throw TestError.invalidDateFixture
    }

    formatter.dateFormat = targetFormat
    formatter.timeZone = outputTimeZone

    return formatter.string(from: date)
  }

  private func makeLocalizedISODate(
    _ input: String,
    dateStyle: DateFormatter.Style,
    timeStyle: DateFormatter.Style
  ) throws -> String {
    let isoFormatter = ISO8601DateFormatter()
    guard let date = isoFormatter.date(from: input) else {
      throw TestError.invalidDateFixture
    }

    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale.current
    outputFormatter.timeZone = TimeZone.current
    outputFormatter.dateStyle = dateStyle
    outputFormatter.timeStyle = timeStyle

    return outputFormatter.string(from: date)
  }

  private func makeLocalizedISODate(
    _ input: String,
    template: String
  ) throws -> String {
    let isoFormatter = ISO8601DateFormatter()
    guard let date = isoFormatter.date(from: input) else {
      throw TestError.invalidDateFixture
    }

    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale.current
    outputFormatter.timeZone = TimeZone.current
    outputFormatter.setLocalizedDateFormatFromTemplate(template)

    return outputFormatter.string(from: date)
  }

  private enum TestError: Error {
    case invalidDateFixture
  }
}
