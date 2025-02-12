//
//  ScreenshotPreventionModifier.swift
//  DesignSystem
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import UIKit

struct ScreenshotPreventionModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
          makeSecure(window: window)
        }
      }
  }
  
  private func makeSecure(window: UIWindow) {
    let field = UITextField()
    let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.width, height: field.frame.height))
    
    // 투명한 이미지뷰 생성
    let image = UIImageView()
    image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    image.backgroundColor = .clear
    
    field.isSecureTextEntry = true
    
    window.addSubview(field)
    view.addSubview(image)
    window.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.last?.addSublayer(window.layer)
    
    field.leftView = view
    field.leftViewMode = .always
  }
}

public extension View {
  func preventScreenshot() -> some View {
    modifier(ScreenshotPreventionModifier())
  }
}
