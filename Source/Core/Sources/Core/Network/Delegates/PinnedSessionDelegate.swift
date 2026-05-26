//
//  PinnedSessionDelegate.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import CryptoKit
import Foundation
import Security

final class PinnedSessionDelegate: NSObject, URLSessionDelegate {
  typealias URLSessionHandler = (URLSession.AuthChallengeDisposition,
                                 URLCredential?) -> Void
  private let pinnedPublicKeyHashes: [Data]
  private let rsaOID: [UInt] = [1, 2, 840, 113_549, 1, 1, 1]
  private let ecOID: [UInt] = [1, 2, 840, 10045, 2, 1]

  init(pinnedPublicKeyHashes: [Data]) {
    self.pinnedPublicKeyHashes = pinnedPublicKeyHashes
  }

  convenience init(pinnedPublicKeyBase64Hashes: [String]) {
    let maxLenght = 32
    let decoded: [Data] = pinnedPublicKeyBase64Hashes
      .compactMap { Data(base64Encoded: $0) }
      .filter { $0.count == maxLenght }
    self.init(pinnedPublicKeyHashes: decoded)
  }

  convenience init(pinnedPublicKeyBase64Hashes: String...) {
    self.init(pinnedPublicKeyBase64Hashes: pinnedPublicKeyBase64Hashes)
  }

  func urlSession(_: URLSession,
                  didReceive challenge: URLAuthenticationChallenge,
                  completionHandler: @escaping URLSessionHandler) {
    guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
          let serverTrust = challenge.protectionSpace.serverTrust
    else {
      completionHandler(.performDefaultHandling, nil)
      return
    }

    if isPinned(serverTrust: serverTrust) {
      completionHandler(.useCredential, URLCredential(trust: serverTrust))
    } else {
      completionHandler(.cancelAuthenticationChallenge, nil)
    }
  }

  func isPinned(serverTrust: SecTrust) -> Bool {
    var error: CFError?
    guard SecTrustEvaluateWithError(serverTrust, &error), error == nil
    else {
      return false
    }

    let certChain = (SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate]) ?? []

    for cert in certChain {
      guard let publicKey = SecCertificateCopyKey(cert) else { continue }
      guard let spki = subjectPublicKeyInfo(for: publicKey) else { continue }
      let digest = SHA256.hash(data: spki)
      if pinnedPublicKeyHashes.contains(Data(digest)) {
        return true
      }
    }

    return false
  }

  private func subjectPublicKeyInfo(for publicKey: SecKey) -> Data? {
    guard let attrs = SecKeyCopyAttributes(publicKey) as? [CFString: CFString],
          let keyType = attrs[kSecAttrKeyType],
          let keySizeBits = attrs[kSecAttrKeySizeInBits] as? Int
    else {
      return nil
    }

    var cfError: Unmanaged<CFError>?
    guard let keyBytes = SecKeyCopyExternalRepresentation(publicKey, &cfError) as Data?
    else {
      return nil
    }

    let algId: Data? = if keyType == kSecAttrKeyTypeRSA {
      rsaAlgorithmIdentifier()
    } else if keyType == kSecAttrKeyTypeECSECPrimeRandom {
      ecAlgorithmIdentifier(curveBits: keySizeBits)
    } else {
      nil
    }
    guard let algorithmIdentifier = algId else { return nil }

    var bitStringContent = Data([0x00])
    bitStringContent.append(keyBytes)
    let subjectPublicKey = derWrap(tag: 0x03, content: bitStringContent)

    var spkiContent = Data()
    spkiContent.append(algorithmIdentifier)
    spkiContent.append(subjectPublicKey)
    return derWrap(tag: 0x30, content: spkiContent)
  }

  private func rsaAlgorithmIdentifier() -> Data {
    let oid = derEncodeOID(rsaOID)
    var content = Data()
    content.append(oid)
    content.append(derNull())
    return derWrap(tag: 0x30, content: content)
  }

  private func ecAlgorithmIdentifier(curveBits: Int) -> Data? {
    let algOID = derEncodeOID(ecOID)

    let curveOID: [UInt]? = switch curveBits {
    case 256:
      [1, 2, 840, 10045, 3, 1, 7]
    case 384:
      [1, 3, 132, 0, 34]
    case 521:
      [1, 3, 132, 0, 35]
    default:
      nil
    }
    guard let curve = curveOID.map(derEncodeOID) else { return nil }

    var content = Data()
    content.append(algOID)
    content.append(curve)
    return derWrap(tag: 0x30, content: content)
  }

  private func derNull() -> Data {
    Data([0x05, 0x00])
  }

  private func derWrap(tag: UInt8, content: Data) -> Data {
    var data = Data([tag])
    data.append(derEncodeLength(content.count))
    data.append(content)
    return data
  }

  private func derEncodeLength(_ length: Int) -> Data {
    if length < 128 {
      return Data([UInt8(length)])
    }
    var len = length
    var bytes: [UInt8] = []
    while len > 0 {
      bytes.insert(UInt8(len & 0xFF), at: 0)
      len >>= 8
    }
    var data = Data([0x80 | UInt8(bytes.count)])
    data.append(contentsOf: bytes)
    return data
  }

  private func derEncodeOID(_ oid: [UInt]) -> Data {
    var body = Data()
    let first = 40 * oid[0] + oid[1]
    body.append(UInt8(first))
    for vector in oid.dropFirst(2) {
      var stack: [UInt8] = []
      var value = vector
      repeat {
        stack.insert(UInt8(value & 0x7F), at: 0)
        value >>= 7
      } while value > 0
      for (index, element) in stack.enumerated() {
        body.append(index < stack.count - 1 ? (element | 0x80) : element)
      }
    }
    return derWrap(tag: 0x06, content: body)
  }
}
