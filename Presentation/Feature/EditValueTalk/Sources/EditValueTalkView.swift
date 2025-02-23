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
    updateProfileValueTalksUseCase: UpdateProfileValueTalksUseCase,
    connectSseUseCase: ConnectSseUseCase,
    disconnectSseUseCase: DisconnectSseUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        getProfileValueTalksUseCase: getProfileValueTalksUseCase,
        updateProfileValueTalksUseCase: updateProfileValueTalksUseCase,
        connectSseUseCase: connectSseUseCase,
        disconnectSseUseCase: disconnectSseUseCase
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
    .onAppear {
      viewModel.handleAction(.onAppear)
    }
    .onDisappear {
      viewModel.handleAction(.onDisappear)
    }
  }
  
  private var valueTalks: some View {
    ForEach(
      Array(viewModel.cardViewModels.enumerated()),
      id: \.1.model.id
    ) { index, cardViewModel in
      EditValueTalkCard(
        viewModel: cardViewModel,
        isEditingAnswer: viewModel.isEditing
      )
      if index < viewModel.cardViewModels.count - 1 {
        Divider(weight: .thick)
      }
    }
  }
}
