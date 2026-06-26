//
//  PinnedSessionDelegateTests.swift
//  Core
//
//  Created by Tiago de Oliveira on 24/05/26.
//

@testable import Core
import Foundation
import Security
import Testing

struct PinnedSessionDelegateTests {
  private let pinnedPublicKeyBase64Hash = "Hfau5HLTVyi4X6w1+lNMHT6j0Qs+haPMpFsTw/KYzao="
  private var pinnedPublicKeyHash: Data {
    Data(base64Encoded: pinnedPublicKeyBase64Hash) ?? Data()
  }

  private let ecPinnedPublicKeyBase64Hash = "0kf/pwUMfO9xFzWSrV7QZPmsSUGdiX98OCFtoL4JA24="

  private let certificateBase64 = """
  MIIDGzCCAgOgAwIBAgIUJvyg9HNu3pSBksIO2oQ/vKYZYUwwDQYJKoZIhvcNAQELBQAwHDEaMBgGA1UEAwwRUGlu
  bmluZyBUZXN0IFJvb3QwIBcNMjYwNTI0MDMzNzE3WhgPMjEwMDA0MjYwMzM3MTdaMBwxGjAYBgNVBAMMEVBpbm5p
  bmcgVGVzdCBSb290MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx+gdTr+8CU6vLyUGugHeubfFGPaV
  AVi2+jmQJRvYI/oZAUHroPmtjdc7ITMGG3AqiP8kebWmFA0bTbepccR3UtCqDNyDskfpCiik17agmSYNiy99hA/R
  GWcJEoAYa+siAtfNvRWrqlypkXhXBRbTw33lHidJ+Sea4t6X7b6gjW88zNetvLD/TUH+r8sLIvBybck1/GFnJplN
  /7JSnAL7odgf44TMHpzfrae8I2JxijaTVd/DFK/HrIrIm6So6thPZaKefdlIpPy5OFDEDXyLR6SYtILAxg0pPQcN
  iGs7CmsrSZ09eoaWhPBom2Y3X8af9L226zsW5/a5+oDx6aHoFQIDAQABo1MwUTAdBgNVHQ4EFgQUIRnjiQqO785t
  nMg8SqMt8esdlZEwHwYDVR0jBBgwFoAUIRnjiQqO785tnMg8SqMt8esdlZEwDwYDVR0TAQH/BAUwAwEB/zANBgkq
  hkiG9w0BAQsFAAOCAQEAvjzWosab1LEZbgA5iPdVKD78ZdUhSOkUDQYpDeSjs42AHkXmo0Fn9de1c5s9V72uLyv8
  Pida/ixB29DB/w0b731EDwl2oeXoIKtd1XpWtTU6IeiBUyATtdGHooi1El+RDiePWMykUvPq0HZuj9SXkB7Gzlyd
  yGjh7hCJ6jWgqjGl3c2+W3HC3qxg8C7tR8g8udmimhwNe6l60sjP5crTeKUBSRB4onqYwlyF/H2aDMdIOWBRqiys
  yzZNhWUs7ZV4DlnLyfa+qOZH+V/Z5isdQ8UCyiA9QsKdFewjEZO3lbNNEGpxTEheOFEVZejAtBMttCoL4wCZ3ssX
  N/BByguBMA==
  """

  private let ecCertificateBase64 = """
  MIIBlDCCATugAwIBAgIUevKNAEBptjqGXfTHdXAMaqnSoLcwCgYIKoZIzj0EAwIwHzEdMBsGA1UEAwwURUMgUGlu
  bmluZyBUZXN0IFJvb3QwIBcNMjYwNTI0MDM0NTIxWhgPMjEwMDA0MjYwMzQ1MjFaMB8xHTAbBgNVBAMMFEVDIFBp
  bm5pbmcgVGVzdCBSb290MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEp4NwPQbAAzvza3Rlo+/mENdPYwuehva5
  q9PNGvEQQq5q4focEpeF+didVkP8G6iP/nhwpUVTQkphojUjNvGgUqNTMFEwHQYDVR0OBBYEFNzAqS7juX8OP5Ci
  /LGEY7Tk8430MB8GA1UdIwQYMBaAFNzAqS7juX8OP5Ci/LGEY7Tk8430MA8GA1UdEwEB/wQFMAMBAf8wCgYIKoZI
  zj0EAwIDRwAwRAIgcuxeFz7CrEJRovnFA97c0rdBKX9WsehO83vgnSjCpnACIFexhl1DPK2u3EH/R96h1mBrqSfL
  xyAEXH9glUuqm03R
  """

  @Test
  func urlSessionWhenAuthenticationMethodIsNotServerTrustPerformsDefaultHandling() {
    let sut = PinnedSessionDelegate(pinnedPublicKeyHashes: [])
    let challenge = makeChallenge(authenticationMethod: NSURLAuthenticationMethodHTTPBasic)

    let result = performChallenge(challenge, with: sut)

    #expect(result.disposition == .performDefaultHandling)
    #expect(result.credential == nil)
  }

  @Test
  func urlSessionWhenServerTrustIsMissingPerformsDefaultHandling() {
    let sut = PinnedSessionDelegate(pinnedPublicKeyHashes: [])
    let challenge = makeChallenge(authenticationMethod: NSURLAuthenticationMethodServerTrust)

    let result = performChallenge(challenge, with: sut)

    #expect(result.disposition == .performDefaultHandling)
    #expect(result.credential == nil)
  }

  @Test
  func isPinnedWhenServerTrustEvaluationFailsReturnsFalse() throws {
    let sut = PinnedSessionDelegate(pinnedPublicKeyHashes: [pinnedPublicKeyHash])
    let trust = try makeServerTrust(anchorCertificate: false,
                                    certificateBase64: certificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == false)
  }

  @Test
  func isPinnedWhenServerTrustIsValidButPinDoesNotMatchReturnsFalse() throws {
    let sut = PinnedSessionDelegate(pinnedPublicKeyHashes: [Data(repeating: 0x01, count: 32)])
    let trust = try makeServerTrust(anchorCertificate: true,
                                    certificateBase64: certificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == false)
  }

  @Test
  func isPinnedWhenServerTrustIsValidAndPinnedPublicKeyHashMatchesReturnsTrue() throws {
    let sut = PinnedSessionDelegate(pinnedPublicKeyHashes: [pinnedPublicKeyHash])
    let trust = try makeServerTrust(anchorCertificate: true,
                                    certificateBase64: certificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == true)
  }

  @Test
  func isPinnedWhenBase64PinnedPublicKeyHashMatchesReturnsTrue() throws {
    let sut = PinnedSessionDelegate(pinnedPublicKeyBase64Hashes: pinnedPublicKeyBase64Hash)
    let trust = try makeServerTrust(anchorCertificate: true,
                                    certificateBase64: certificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == true)
  }

  @Test
  func isPinnedWhenEllipticCurvePinnedPublicKeyHashMatchesReturnsTrue() throws {
    let sut = PinnedSessionDelegate(pinnedPublicKeyBase64Hashes: ecPinnedPublicKeyBase64Hash)
    let trust = try makeServerTrust(anchorCertificate: true,
                                    certificateBase64: ecCertificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == true)
  }

  @Test
  func isPinnedWhenBase64PinnedPublicKeyHashIsInvalidIgnoresHashAndReturnsFalse() throws {
    let sut = PinnedSessionDelegate(
      pinnedPublicKeyBase64Hashes: [
        "not-base64",
        Data(repeating: 0x01, count: 31).base64EncodedString()
      ]
    )
    let trust = try makeServerTrust(anchorCertificate: true,
                                    certificateBase64: certificateBase64)

    let result = sut.isPinned(serverTrust: trust)

    #expect(result == false)
  }

  private func performChallenge(
    _ challenge: URLAuthenticationChallenge,
    with sut: PinnedSessionDelegate
  ) -> (disposition: URLSession.AuthChallengeDisposition, credential: URLCredential?) {
    var receivedDisposition: URLSession.AuthChallengeDisposition?
    var receivedCredential: URLCredential?

    sut.urlSession(URLSession(configuration: .ephemeral), didReceive: challenge) { disposition, credential in
      receivedDisposition = disposition
      receivedCredential = credential
    }

    #expect(receivedDisposition != nil)
    return (receivedDisposition ?? .rejectProtectionSpace, receivedCredential)
  }

  private func makeChallenge(authenticationMethod: String) -> URLAuthenticationChallenge {
    let protectionSpace = URLProtectionSpace(
      host: "example.com",
      port: 443,
      protocol: NSURLProtectionSpaceHTTPS,
      realm: nil,
      authenticationMethod: authenticationMethod
    )
    return URLAuthenticationChallenge(
      protectionSpace: protectionSpace,
      proposedCredential: nil,
      previousFailureCount: 0,
      failureResponse: nil,
      error: nil,
      sender: ChallengeSenderDummy()
    )
  }

  private func makeServerTrust(
    anchorCertificate: Bool,
    certificateBase64: String
  ) throws -> SecTrust {
    let certificate = try makeCertificate(base64: certificateBase64)
    var optionalTrust: SecTrust?
    let status = SecTrustCreateWithCertificates(certificate, SecPolicyCreateBasicX509(), &optionalTrust)
    #expect(status == errSecSuccess)

    guard let trust = optionalTrust
    else {
      throw TestError.missingTrust
    }

    if anchorCertificate {
      #expect(SecTrustSetAnchorCertificates(trust, [certificate] as CFArray) == errSecSuccess)
      #expect(SecTrustSetAnchorCertificatesOnly(trust, true) == errSecSuccess)
    }

    return trust
  }

  private func makeCertificate(base64: String) throws -> SecCertificate {
    guard
      let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters),
      let certificate = SecCertificateCreateWithData(nil, data as CFData)
    else {
      throw TestError.invalidCertificateFixture
    }
    return certificate
  }

  private enum TestError: Error {
    case invalidCertificateFixture
    case missingTrust
  }

  private final class ChallengeSenderDummy: NSObject, URLAuthenticationChallengeSender {
    func use(_: URLCredential, for _: URLAuthenticationChallenge) {}

    func continueWithoutCredential(for _: URLAuthenticationChallenge) {}

    func cancel(_: URLAuthenticationChallenge) {}
  }
}
