//
//  ValuePickCard.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

import DesignSystem
import SwiftUI

struct ValuePickCard: View {
  init(valuePick: ValuePickAnswerModel) {
    self.model = valuePick
  }
  
  private let model: ValuePickAnswerModel
  
  var body: some View {
    VStack(spacing: 24) {
      question
      answers
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .background {
      RoundedRectangle(cornerRadius: 12)
        .foregroundStyle(Color.grayscaleWhite)
    }
  }
  
  private var question: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack(alignment: .center) {
        category
        Spacer()
        if model.sameWithMe {
          Badge(badgeText: "나와 같은")
        }
      }
      
      Text(model.question)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
        .pretendard(.body_M_SB)
        .foregroundStyle(Color.grayscaleBlack)
    }
  }
  
  private var category: some View {
    HStack(alignment: .center, spacing: 6) {
      DesignSystemAsset.Icons.question20.swiftUIImage
        .renderingMode(.template)
        .foregroundStyle(Color.primaryDefault)
      
      Text(model.category)
        .pretendard(.body_S_SB)
        .foregroundStyle(Color.primaryDefault)
    }
  }
  
  private var answers: some View {
    VStack(spacing: 8) {
//      ForEach(valuePick.answers) { answer in
//        SelectCard(isSelected: answer.isSelected, text: answer.content)
//      }
    }
  }
}

//#Preview {
//  ValuePickCard(
//    valuePick: ValuePickModel(
//      id: 0,
//      category: "음주",
//      question: "연인과 함께 술을 마시는 것을 좋아하나요?",
//      answers: [
//        ValuePickAnswerModel(
//          id: 1,
//          content: "함께 술을 즐기고 싶어요",
//          isSelected: true
//        ),
//        ValuePickAnswerModel(
//          id: 2,
//          content: "같이 술을 즐길 수 없어도 괜찮아요",
//          isSelected: false
//        ),
//      ],
//      isSame: true
//    )
//  )
//}
