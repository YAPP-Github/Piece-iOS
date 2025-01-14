//
//  PCTextButton.swift
//  DesignSystem
//
//  Created by summercat on 1/14/25.
//

import SwiftUI

public struct PCTextButton: View {
  public init(content: String) {
    self.content = content
  }
  
  public var body: some View {
      Text(content)
        .pretendard(.body_M_M)
        .foregroundStyle(Color.grayscaleDark3)
        .overlay(alignment: .bottom) {
          Rectangle()
            .foregroundStyle(Color.grayscaleDark3)
            .frame(height: 1)
        }
        .contentShape(Rectangle())
  }
  
  let content: String
}

#Preview {
  PCTextButton(content: "텍스트")
}
