//
//  UIImage+Extensions.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/06/26.
//

import UIKit

public extension UIImage {
  func croppedToAspectRatio(ratio: CGFloat) -> UIImage {
    let currentRatio = size.width / size.height
    let cropSize = if currentRatio > ratio {
      CGSize(
        width: size.height * ratio,
        height: size.height
      )
    } else {
      CGSize(
        width: size.width,
        height: size.width / ratio
      )
    }
    let cropOrigin = CGPoint(
      x: (size.width - cropSize.width) / 2,
      y: (size.height - cropSize.height) / 2
    )
    let rect = CGRect(origin: cropOrigin, size: cropSize)
    guard let cgImage,
          let croppedCGImage = cgImage.cropping(to: rect) else {
      return self
    }
    return UIImage(
      cgImage: croppedCGImage,
      scale: scale,
      orientation: imageOrientation
    )
  }
}
