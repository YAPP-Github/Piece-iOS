//
//  PCToast.swift
//  DesignSystem
//
//  Created by summercat on 2/11/25.
//

import SwiftUI

public struct PCToast: View {
  private let icon: Image?
  private let text: String
  
  public init(
    icon: Image? = nil,
    text: String
  ) {
    self.icon = icon
    self.text = text
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 8) {
      icon?
        .renderingMode(.template)
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(Color.grayscaleWhite)
      
      Text(text)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleWhite)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .foregroundStyle(Color.grayscaleDark2)
    )
  }
}

#Preview {
  PCToast(
    icon: DesignSystemAsset.Icons.question20.swiftUIImage,
    text: "토스트"
  )
}
