//
//  UIImage+Extension.swift
//  PCFoundationExtension
//
//  Created by eunseou on 2/12/25.
//

import SwiftUI

public extension UIImage {
  static func resizeImage(_ image: UIImage, targetSize: CGSize = CGSize(width: 1024, height: 1024)) -> UIImage {
    let size = image.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let scalingFactor = min(widthRatio, heightRatio)
    
    let newSize = CGSize(width: size.width * scalingFactor, height: size.height * scalingFactor)
    let renderer = UIGraphicsImageRenderer(size: newSize)
    
    return renderer.image { _ in
      image.draw(in: CGRect(origin: .zero, size: newSize))
    }
  }
  
  func resizedAndCompressedData(targetSize: CGSize = CGSize(width: 1024, height: 1024), compressionQuality: CGFloat = 0.5) -> Data? {
    let resizedImage = UIImage.resizeImage(self, targetSize: targetSize)
    return resizedImage.jpegData(compressionQuality: compressionQuality)
  }
}
