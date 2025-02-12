//
//  Pagenation.swift
//  DesignSystem
//
//  Created by summercat on 2/12/25.
//

import SwiftUI

public struct Pagenation: View {
  let totalCount: Int
  let currentIndex: Int
  
  public init(totalCount: Int, currentIndex: Int) {
    self.totalCount = totalCount
    self.currentIndex = currentIndex
  }
  
  public var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<totalCount, id: \.self) { index in
        let isSelected = index == currentIndex
        Capsule()
          .fill(isSelected ? Color.grayscaleDark2 : Color.grayscaleLight1)
          .frame(
            width: isSelected ? 20 : 8,
            height: 8
          )
          .animation(.spring(response: 0.3), value: isSelected)
      }
    }
  }
}

#Preview {
  Pagenation(totalCount: 5, currentIndex: 2)
}
