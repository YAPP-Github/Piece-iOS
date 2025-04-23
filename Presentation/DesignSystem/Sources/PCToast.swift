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
    text: String
  ) {
    self._isVisible = isVisible
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
}

#Preview {
  PCToast(
    isVisible: .constant(true),
    icon: DesignSystemAsset.Icons.question20.swiftUIImage,
    text: "토스트"
  )
}
