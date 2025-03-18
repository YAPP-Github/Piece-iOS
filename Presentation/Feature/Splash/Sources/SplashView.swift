//
// SplashView.swift
// Splash
//
// Created by summercat on 2025/02/14.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct SplashView: View {
  @State var viewModel: SplashViewModel
  @Environment(Router.self) var router
  
  init(getUserInfoUseCase: GetUserInfoUseCase) {
    _viewModel = .init(
      wrappedValue: .init(
        getUserInfoUseCase: getUserInfoUseCase
      )
    )
  }
  
  var body: some View {
    DesignSystemAsset.Icons.logoCircle3x.swiftUIImage
      .resizable()
      .frame(width: 160, height: 160)
      .onAppear {
        viewModel.handleAction(.onAppear)
      }
      .onChange(of: viewModel.destination) { _, destination in
        guard let destination else { return }
        router.setRoute(destination)
      }
      .pcAlert(isPresented: $viewModel.showNeedsForceUpdateAlert) {
        AlertView(
          title: {
            Text("Piece가 새로운 버전으로\n업데이트되었어요!")
              .pretendard(.heading_M_SB)
              .foregroundStyle(.grayscaleBlack)
          },
          message: "여러분의 의견을 반영하여 사용성을 개선했습니다.\n지금 바로 업데이트해 보세요!",
          secondButtonText: "앱 업데이트하기"
        ) {
          viewModel.handleAction(.openAppStore)
        }
      }
  }
}
