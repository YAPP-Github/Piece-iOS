//
//  AnswerOption.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct AnswerOption: View {

  public init(
    isSelected: Bool,
    text: String,
    action: (() -> Void)? = nil
  ) {
    self.isSelected = isSelected
    self.text = text
    self.action = action
  }
  
  public var body: some View {
    Button {
      action?()
    } label: {
      Text(text)
        .pretendard(.body_S_SB)
        .foregroundStyle(isSelected ? Color.primaryDefault : Color.grayscaleDark2)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(isSelected ? Color.primaryLight : Color.grayscaleLight2)
        )
    }
  }
  
  private let isSelected: Bool
  private let text: String
  private let action: (() -> Void)?
}

#Preview {
  VStack {
    AnswerOption(isSelected: true, text: "selected")
    AnswerOption(isSelected: false, text: "unselected")
  }
}
