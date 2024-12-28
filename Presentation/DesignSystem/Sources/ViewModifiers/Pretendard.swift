//
//  Pretendard.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

struct Pretendard: ViewModifier {
  let font: Fonts.Pretendard
  
  func body(content: Content) -> some View {
    content
      .font(font.swiftUIFont)
      .lineSpacing(font.lineHeight - font.uiFont.lineHeight)
      .padding(.vertical, (font.lineHeight - font.uiFont.lineHeight) / 2)
  }
}

public extension SwiftUI.View {
  func pretendard(_ font: Fonts.Pretendard) -> some View {
    modifier(Pretendard(font: font))
  }
}
