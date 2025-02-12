//
// SettingsView.swift
// Settings
//
// Created by summercat on 2025/02/12.
//

import DesignSystem
import SwiftUI
import UseCases

struct SettingsView: View {
  @State var viewModel: SettingsViewModel
  
  init(fetchTermsUseCase: FetchTermsUseCase) {
    _viewModel = .init(wrappedValue: .init(fetchTermsUseCase: fetchTermsUseCase))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HomeNavigationBar(
        title: "Settings",
        foregroundColor: .grayscaleBlack
      )
      Divider(weight: .normal, isVertical: false)
      ScrollView(showsIndicators: false) {
        VStack(spacing: 16) {
          PCTextButton(content: "탈퇴하기")
            .onTapGesture {
              viewModel.handleAction(.withdrawButtonTapped)
            }
          
          Spacer()
        }
        .padding(.vertical, 20)
      }
      .contentMargins(.horizontal, 20)
      .padding(.bottom, 89) // 탭바 높이 만큼 패딩
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear {
      viewModel.handleAction(.onAppear)
    }
  }
}
