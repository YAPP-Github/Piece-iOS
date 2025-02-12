//
// EditValuePickView.swift
// EditValuePick
//
// Created by summercat on 2025/02/12.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct EditValuePickView: View {
  @State var viewModel: EditValuePickViewModel
  @Environment(Router.self) var router: Router
  
  init(getMatchValuePicksUseCase: GetMatchValuePicksUseCase) {
    _viewModel = .init(
      wrappedValue: .init(
        getMatchValuePicksUseCase: getMatchValuePicksUseCase
      )
    )
  }

  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "가치관 Pick",
        leftButtonTap: { router.pop() },
        rightButtonTap: { viewModel.isEditing.toggle() /*TODO: - 상태에 따라 수정*/ },
        label: viewModel.isEditing ? "저장": "수정",
        labelColor: viewModel.isEditing ? Color.grayscaleDark3 : Color.primaryDefault,
        backgroundColor: .clear
      )
      
      ScrollView {
        valuePicks
      }
      .scrollIndicators(.hidden)
    }
    .frame(maxHeight: .infinity)
    .background(Color.grayscaleWhite)
    .toolbar(.hidden)
  }
  
  private var valuePicks: some View {
    ForEach(
      Array(zip(viewModel.valuePicks.indices, viewModel.valuePicks)),
      id: \.1
    ) { index, valuePick in
      ValuePickCard(
        valuePick: valuePick,
        isEditing: viewModel.isEditing
      ) { model in
        viewModel.handleAction(.updateValuePick(model))
      }
      if index < viewModel.valuePicks.count - 1 {
        Divider(weight: .thick)
      }
    }
  }
}
