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
  @State private var viewModel: EditValueTalkCardViewModel
  private var focusState: FocusState<EditValueTalkView.Field?>.Binding
  let index: Int
  let isEditing: Bool
  
  init(
    viewModel: EditValueTalkCardViewModel,
    focusState: FocusState<EditValueTalkView.Field?>.Binding,
    index: Int,
    isEditing: Bool
  ) {
    _viewModel = .init(wrappedValue: viewModel)
    self.focusState = focusState
    self.index = index
    self.isEditing = isEditing
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      question
        .contentShape(Rectangle())
        .onTapGesture {
          // 질문 영역 탭 시 포커스 해제
          focusState.wrappedValue = nil
        }
      Spacer()
        .frame(height: 20)
      answer
      Spacer()
        .frame(height: 12)
      if viewModel.isEditingAnswer {
        guide
          .contentShape(Rectangle())
          .onTapGesture {
            // 도움말 영역 탭 시 포커스 해제
            focusState.wrappedValue = nil
          }
      }
      
      if !viewModel.isEditingAnswer {
        Spacer()
          .frame(height: 20)
        summary
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .background(Color.grayscaleWhite)
    .contentShape(Rectangle())
    .onTapGesture {
      // 카드 전체 영역 탭 시 포커스 해제 (자식 뷰에서 이벤트가 처리되지 않은 경우에만)
      focusState.wrappedValue = nil
    }
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
          if viewModel.localAnswer.isEmpty && focusState.wrappedValue != .answerEditor(index) {
            Text(viewModel.model.placeholder)
              .pretendard(.body_M_M)
              .foregroundStyle(Color.grayscaleDark3)
              .padding(.top, 4)
          }
        }
        .focused(focusState, equals: .answerEditor(index))
        .allowsHitTesting(isEditing) // 편집 모드에서만 탭 가능하도록
        .onTapGesture {
          if isEditing {
            focusState.wrappedValue = .answerEditor(index)
          }
        }
      
      if !viewModel.localAnswer.isEmpty || focusState.wrappedValue == .answerEditor(index) {
        TextCountIndicator(count: .constant(viewModel.localAnswer.count), maxCount: 300)
          .contentShape(Rectangle())
          .onTapGesture {
            // 카운터 영역 탭 시 포커스 해제
            focusState.wrappedValue = nil
          }
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .foregroundStyle(Color.grayscaleLight3)
    )
    .contentShape(Rectangle())
    .onTapGesture {
      // TextEditor 주변 패딩 탭 시 처리
      if isEditing && focusState.wrappedValue != .answerEditor(index) {
        focusState.wrappedValue = .answerEditor(index)
      } else {
        focusState.wrappedValue = nil
      }
    }
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
      .contentShape(Rectangle())
      .onTapGesture {
        focusState.wrappedValue = nil
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
          .focused(focusState, equals: .summaryEditor(index))
          .allowsHitTesting(viewModel.editingState == .editingSummary)
          .onTapGesture {
            if viewModel.editingState == .editingSummary {
              focusState.wrappedValue = .summaryEditor(index)
            } else {
              focusState.wrappedValue = nil
            }
          }
          
          summaryButton
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundStyle(Color.grayscaleLight3)
      )
      .contentShape(Rectangle())
      .onTapGesture {
        // 요약 영역 배경 탭 시
        if viewModel.editingState == .editingSummary && focusState.wrappedValue != .summaryEditor(index) {
          focusState.wrappedValue = .summaryEditor(index)
        } else {
          focusState.wrappedValue = nil
        }
      }
      
      if case .editingSummary = viewModel.editingState {
        TextCountIndicator(count: .constant(viewModel.localSummary.count), maxCount: 50)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .contentShape(Rectangle())
          .onTapGesture {
            focusState.wrappedValue = nil
          }
      }
    }
  }
  
  @ViewBuilder
  private var summaryButton: some View {
    Button {
      focusState.wrappedValue = nil // 버튼 탭 시 포커스 해제
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
