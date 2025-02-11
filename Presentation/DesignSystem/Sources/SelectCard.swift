//
//  SelectCard.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct SelectCard: View {
  /// SelectCard
  /// - Parameters:
  ///   - isEditing: 기본값 false. 편집 상태일 경우 true.
  ///   - isSelected: 선택한 응답인지
  ///   - text: 응답 텍스트
  ///   - tapAction: 탭 액션
  public init(
    isEditing: Bool = false,
    isSelected: Bool,
    text: String,
    tapAction: (() -> Void)? = nil
  ) {
    self.isSelected = isSelected
    self.isEditing = isEditing
    self.text = text
    self.tapAction = tapAction
  }
  
  public var body: some View {
    Button {
      tapAction?()
    } label: {
      Text(text)
        .pretendard(.body_S_SB)
        .foregroundStyle(isSelected ? Color.primaryDefault : Color.grayscaleDark2)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(isSelected ? Color.primaryLight : Color.grayscaleLight3)
        )
        .overlay(border)
    }
  }
  
  @ViewBuilder
  private var border: some View {
    if isEditing && isSelected {
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.primaryDefault, lineWidth: 1)
    } else {
      EmptyView()
    }
  }
  
  private let isEditing: Bool // 편집 상태일때만 true
  private let isSelected: Bool
  private let text: String
  private let tapAction: (() -> Void)?
}

#Preview {
  VStack {
    SelectCard(isSelected: true, text: "selected")
    SelectCard(isEditing: true, isSelected: true, text: "selected editing")
    SelectCard(isSelected: false, text: "unselected")
  }
}
