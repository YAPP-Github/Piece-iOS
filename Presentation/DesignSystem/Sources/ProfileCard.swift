//
//  ProfileCard.swift
//  DesignSystem
//
//  Created by summercat on 1/4/25.
//

import SwiftUI

public struct ProfileCard<Answer: View>: View {
  public enum CardType {
    case matching
    case profile
    
    var backgroundColor: Color {
      switch self {
      case .matching: .alphaWhite60
      case .profile: .grayscaleLight3
      }
    }
    
    var categoryTextColor: Color {
      .grayscaleDark2
    }
  }
  
  public init(
    type: CardType,
    category: String,
    @ViewBuilder answer: () -> Answer
  ) {
    self.type = type
    self.category = category
    self.answer = answer()
  }
  
  public var body: some View {
    content
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(type.backgroundColor)
      )
  }
  
  private var content: some View {
    VStack(alignment: .center, spacing: 8) {
      Text(category)
        .lineLimit(1)
        .truncationMode(.tail)
        .pretendard(Fonts.Pretendard.body_S_M)
        .foregroundStyle(type.categoryTextColor)
      
      answer
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 16)
  }
  
  private let type: CardType
  private let category: String
  @ViewBuilder let answer: Answer
}

#Preview {
  let answer = {
    HStack(alignment: .center, spacing: 4) {
      Text("만")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleBlack)
      HStack(alignment: .center, spacing: 0) {
        Text("00")
          .pretendard(.heading_S_SB)
          .foregroundStyle(Color.grayscaleBlack)
        Text("세")
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleBlack)
      }
      Text("00년생")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark2)
    }
  }
  
  HStack {
    ProfileCard(
      type: .profile,
      category: "Category",
      answer: answer
    )
    
    ProfileCard(
      type: .profile,
      category: "Category",
      answer: answer
    )
    .frame(width: 250)
  }
}
