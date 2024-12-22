//
//  Tag.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct Tag: View {
  public init(
    badgeText: String,
    backgroundColor: Color = Color.primaryLight,
    textColor: Color = Color.grayscaleBlack
  ) {
    self.badgeText = badgeText
    self.backgroundColor = backgroundColor
    self.textColor = textColor
  }
  
  public var body: some View {
    Text(badgeText)
      .pretendard(.body_M_R)
      .foregroundStyle(textColor)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(
        RoundedRectangle(cornerRadius: 4)
          .foregroundStyle(backgroundColor)
      )
  }
  
  private let badgeText: String
  private let backgroundColor: Color
  private let textColor: Color
}

#Preview {
  Tag(badgeText: "태그")
}
