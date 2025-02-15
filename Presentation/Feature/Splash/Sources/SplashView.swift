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
  
  init(
    getServerStatusUseCase: GetServerStatusUseCase,
    socialLoginUseCase: SocialLoginUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        getServerStatusUseCase: getServerStatusUseCase,
        socialLoginUseCase: socialLoginUseCase
      )
    )
  }
  
  var body: some View {
    DesignSystemAsset.Images.logo.swiftUIImage
      .onAppear {
        viewModel.handleAction(.onAppear)
      }
      .onChange(of: viewModel.destination) { _, destination in
        guard let destination else { return }
        router.push(to: destination)
      }
  }
}
//
//#Preview {
//  SplashView(viewModel: SplashViewModel())
//}
