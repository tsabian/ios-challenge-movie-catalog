//
//  ImageLoadingServiceProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation
import SwiftUI

protocol ImageLoadingServiceProtocol {
  func fetchImage(from pathURLString: String, withSize size: TMDBImageSize) async throws -> UIImage
}
