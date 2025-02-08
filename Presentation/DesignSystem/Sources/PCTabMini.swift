//
//  PCTabMini.swift
//  DesignSystem
//
//  Created by summercat on 1/14/25.
//

import SwiftUI

public struct PCMiniTab<Content: View>: View {
  public init(
    isSelected: Bool,
    @ViewBuilder content: () -> Content
  ) {
    self.isSelected = isSelected
    self.content = content()
  }
  
  public var body: some View {
    content
      .pretendard(.body_M_M)
      .foregroundStyle(isSelected ? Color.grayscaleBlack : Color.grayscaleDark3)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .contentShape(Rectangle())
  }
  
  let isSelected: Bool
  let content: Content
}

#Preview {
  HStack(alignment: .top) {
    PCMiniTab(isSelected: true) {
      Text("전체")
    }
    
    PCMiniTab(isSelected: false) {
      Text("전체")
    }
  }
}
