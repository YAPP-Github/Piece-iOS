//
//  EditValueTalkCard.swift
//  EditValueTalk
//
//  Created by summercat on 2/9/25.
//

import DesignSystem
import Entities
import SwiftUI

struct EditValueTalkCard: View {
  @FocusState var isEditingAnswer: Bool
  @FocusState var isEditingSummary: Bool
  @State private var viewModel: EditValueTalkCardViewModel

  init(
    viewModel: EditValueTalkCardViewModel,
    isEditingAnswer: Bool
  ) {
    _viewModel = .init(wrappedValue: viewModel)
    self.isEditingAnswer = isEditingAnswer
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      question
      Spacer()
        .frame(height: 20)
      answer
      Spacer()
        .frame(height: 12)
      if viewModel.isEditingAnswer {
        guide
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .background(Color.grayscaleWhite)
  }
  
  private var question: some View {
    VStack( alignment: .leading, spacing: 6) {
      category
      title
    }
  }
  
  private var category: some View {
    Text(viewModel.model.category)
      .pretendard(.body_M_M)
      .foregroundStyle(Color.primaryDefault)
  }
  
  private var title: some View {
    Text(viewModel.model.title)
      .pretendard(.heading_M_SB)
      .foregroundStyle(Color.grayscaleDark1)
  }
  
  private var answer: some View {
    VStack(spacing: 16) {
      TextEditor(text: Binding(
        get: { viewModel.localAnswer },
        set: { viewModel.handleAction(.didUpdateAnswer($0)) }
      ))
        .frame(maxWidth: .infinity, minHeight: 96)
        .fixedSize(horizontal: false, vertical: true)
        .pretendard(.body_M_M)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.none)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .foregroundStyle(Color.grayscaleBlack)
        .background(alignment: .topLeading) {
          if viewModel.localAnswer.isEmpty && !isEditingAnswer {
            Text(viewModel.model.placeholder)
              .pretendard(.body_M_M)
              .foregroundStyle(Color.grayscaleDark3)
              .padding(.top, 4) // 폰트 내 lineHeight로 인해서 상단이 패딩이 더 커보이는 것 보졍
          }
        }
        .focused($isEditingAnswer)
      
      if !viewModel.localAnswer.isEmpty || isEditingAnswer {
        TextCountIndicator(count: .constant(viewModel.localAnswer.count), maxCount: 300)
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10) // 폰트 내 lineHeight로 인해서 상단이 패딩이 더 커보이는 것 보졍
    .background(
      RoundedRectangle(cornerRadius: 8)
        .foregroundStyle(Color.grayscaleLight3)
    )
  }
  
  private var guide: some View {
    HStack(alignment: .center, spacing: 8) {
      Text("도움말")
        .pretendard(.body_S_R)
        .foregroundStyle(Color.subDefault)
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.subLight)
        )
      Text(viewModel.currentGuideText)
        .pretendard(.body_S_R)
        .foregroundStyle(Color.grayscaleDark2)
        .animation(.bouncy(duration: 1), value: viewModel.currentGuideText)
    }
  }
  
  private var summary: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack(alignment: .center, spacing: 4) {
        Text("AI 요약")
        DesignSystemAsset.Icons.info20.swiftUIImage
          .renderingMode(.template)
          .foregroundStyle(Color.grayscaleDark3)
      }
      
      HStack(alignment: .bottom, spacing: 4) {
        if case .generatingAISummary = viewModel.editingState {
          Text("작성해주신 내용을 AI가 요약하고 있어요")
            .pretendard(.body_M_M)
            .foregroundStyle(.grayscaleDark2)
          PCLottieView(.refresh)
          Spacer()
        } else {
          TextEditor(text: Binding(
            get: { viewModel.localSummary },
            set: { viewModel.handleAction(.didUpdateSummary($0)) }
          ))
          .disabled(viewModel.editingState != .editingSummary)
          .pretendard(.body_M_M)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.none)
          .scrollContentBackground(.hidden)
          .scrollDisabled(true)
          .foregroundStyle(viewModel.editingState == .generatingAISummary ? Color.grayscaleDark2 : Color.grayscaleBlack)
          .focused($isEditingSummary)
          
          summaryButton
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10) // 폰트 내 lineHeight로 인해서 상단이 패딩이 더 커보이는 것 보졍
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundStyle(Color.grayscaleLight3)
      )
      
      if case .editingSummary = viewModel.editingState {
        TextCountIndicator(count: .constant(viewModel.localSummary.count), maxCount: 50)
          .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
  }
  
  @ViewBuilder
  private var summaryButton: some View {
    Button {
      viewModel.handleAction(.didTapSummaryButton)
    } label: {
      switch viewModel.editingState {
      case .viewing:
        DesignSystemAsset.Icons.pencilFill24.swiftUIImage
          .renderingMode(.template)
          .foregroundStyle(Color.primaryDefault)
        
      case .editingAnswer:
        EmptyView()
        
      case .editingSummary:
        DesignSystemAsset.Icons.check24.swiftUIImage
          .renderingMode(.template)
          .foregroundStyle(Color.primaryDefault)
        
      case .generatingAISummary:
        EmptyView()
      }
    }
    .disabled(viewModel.editingState == .generatingAISummary)
  }
}
