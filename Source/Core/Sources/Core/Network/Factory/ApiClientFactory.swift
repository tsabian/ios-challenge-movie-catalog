//
//  ApiClientFactory.swift
//  Core
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

public enum ApiClientFactory {
  public static func make(pinnedPublicKeyBase64Hashes: [String],
                          configuration: URLSessionConfiguration = .default) -> ApiClient {
    let delegate = PinnedSessionDelegate(
      pinnedPublicKeyBase64Hashes: pinnedPublicKeyBase64Hashes
    )
    let session = URLSession(configuration: configuration,
                             delegate: delegate, delegateQueue: nil)
    return ApiClient(session: session)
  }
}
