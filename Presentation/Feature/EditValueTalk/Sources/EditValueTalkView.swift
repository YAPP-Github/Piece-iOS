//
// EditValueTalkView.swift
// EditValueTalk
//
// Created by summercat on 2025/02/13.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct EditValueTalkView: View {
  @State var viewModel: EditValueTalkViewModel
  @Environment(Router.self) var router
  
  init(
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase,
    updateProfileValueTalksUseCase: UpdateProfileValueTalksUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        getProfileValueTalksUseCase: getProfileValueTalksUseCase,
        updateProfileValueTalksUseCase: updateProfileValueTalksUseCase
      )
    )
  }

  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "가치관 Talk",
        leftButtonTap: { router.pop() },
        rightButtonTap: { viewModel.handleAction(.didTapSaveButton) },
        label: viewModel.isEditing ? "저장": "수정",
        labelColor: viewModel.isEditing ? Color.grayscaleDark3 : Color.primaryDefault,
        backgroundColor: .clear
      )
      
      ScrollView {
        valueTalks
      }
      .scrollIndicators(.hidden)
    }
    .frame(maxHeight: .infinity)
    .background(Color.grayscaleWhite)
    .toolbar(.hidden)
  }
  
  private var valueTalks: some View {
    ForEach(
      Array(zip(viewModel.valueTalks.indices, viewModel.valueTalks)),
      id: \.1
    ) { index, valueTalk in
      EditValueTalkCard(
        model: valueTalk,
        index: index,
        isEditingAnswer: viewModel.isEditing
      ) { model in
        viewModel.handleAction(.updateValueTalk(model))
      }
      if index < viewModel.valueTalks.count - 1 {
        Divider(weight: .thick)
      }
    }
  }
}
