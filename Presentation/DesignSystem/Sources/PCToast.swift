//
//  PCToast.swift
//  DesignSystem
//
//  Created by summercat on 2/11/25.
//

import SwiftUI

public struct PCToast: View {
  @Binding public var isVisible: Bool
  private let icon: Image?
  private let text: String
  
  public init(
    isVisible: Binding<Bool>,
    icon: Image? = nil,
    text: String,
    textColor: Color = .grayscaleWhite,
    backgroundColor: Color = .grayscaleDark2
  ) {
    self._isVisible = isVisible
    self.icon = icon
    self.text = text
    self.textColor = textColor
    self.backgroundColor = backgroundColor
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 8) {
      icon?
        .renderingMode(.template)
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(textColor)
      
      Text(text)
        .pretendard(.body_S_M)
        .foregroundStyle(textColor)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .foregroundStyle(backgroundColor)
    )
    .opacity(isVisible ? 1 : 0)
    .animation(.easeInOut, value: isVisible)
    .onChange(of: isVisible) { _, newValue in
      if newValue {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          isVisible = false
        }
      }
    }
  }
  
  private let textColor: Color
  private let backgroundColor: Color
}

#Preview {
  PCToast(
    isVisible: .constant(true),
    icon: DesignSystemAsset.Icons.question20.swiftUIImage,
    text: "토스트"
  )
}
