//
//  ValuePickCard.swift
//  SignUp
//
//  Created by summercat on 2/10/25.
//

import DesignSystem
import Entities
import SwiftUI

struct ValuePickCard: View {
  @State var viewModel: ValuePickCardViewModel
  init(
    valuePick: ProfileValuePickModel,
    onModelUpdate: @escaping (ProfileValuePickModel) -> Void
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        model: valuePick,
        onModelUpdate: onModelUpdate
      ) 
    )
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      question
      answers
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .background {
      RoundedRectangle(cornerRadius: 12)
        .foregroundStyle(Color.grayscaleWhite)
    }
  }
  
  private var question: some View {
    VStack(alignment: .leading, spacing: 12) {
      category
      
      Text(viewModel.model.question)
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
      
      Text(viewModel.model.category)
        .pretendard(.body_S_SB)
        .foregroundStyle(Color.primaryDefault)
    }
  }
  
  private var answers: some View {
    VStack(spacing: 8) {
      ForEach(viewModel.model.answers) { answer in
        SelectCard(
          isEditing: true,
          isSelected: answer.id == viewModel.model.selectedAnswer,
          text: answer.content,
          tapAction: { viewModel.handleAction(.didTapAnswer(id: answer.id)) }
        )
      }
    }
  }
}
