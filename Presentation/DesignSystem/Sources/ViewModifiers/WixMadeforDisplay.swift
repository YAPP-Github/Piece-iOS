//
//  WixMadeforDisplay.swift
//  DesignSystem
//
//  Created by eunseou on 1/5/25.
//

import SwiftUI

struct WixMadeforDisplay: ViewModifier {
  let font: Fonts.WixMadeforDisplay
  
  func body(content: Content) -> some View {
    content
      .font(font.swiftUIFont)
      .lineSpacing(font.lineHeight - font.uiFont.lineHeight)
      .padding(.vertical, (font.lineHeight - font.uiFont.lineHeight) / 2)
  }
}

public extension SwiftUI.View {
  func wixMadeforDisplay(_ font: Fonts.WixMadeforDisplay) -> some View {
    modifier(WixMadeforDisplay(font: font))
  }
}
