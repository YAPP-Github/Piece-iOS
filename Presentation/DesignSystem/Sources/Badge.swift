//
//  Badge.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct Badge: View {
  public init(
    badgeText: String,
    backgroundColor: Color = Color.subLight,
    textColor: Color = Color.subDefault
  ) {
    self.badgeText = badgeText
    self.backgroundColor = backgroundColor
    self.textColor = textColor
  }
  
  public var body: some View {
    Text(badgeText)
      .pretendard(.caption_M_M)
      .foregroundStyle(textColor)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(
        Capsule()
          .foregroundStyle(backgroundColor)
      )
  }
  
  private let badgeText: String
  private let backgroundColor: Color
  private let textColor: Color
}

#Preview {
  Badge(badgeText: "뱃지")
}
