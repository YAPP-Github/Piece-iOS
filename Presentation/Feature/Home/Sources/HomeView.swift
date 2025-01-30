//
// HomeView.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import MatchingMain
import Router
import Profile
import SwiftUI
import UseCases

struct HomeView: View {
  @State private var viewModel: HomeViewModel
  
  init(getProfileUseCase: GetProfileUseCase) {
    _viewModel = .init(wrappedValue: .init(getProfileUseCase: getProfileUseCase))
  }

  var body: some View {
    ZStack {
      content
      TabBarView(viewModel: viewModel.tabbarViewModel)
    }
  }
  
  @ViewBuilder
  private var content: some View {
    switch viewModel.tabbarViewModel.selectedTab {
    case .profile:
      ProfileViewFactory.createProfileView(
        getProfileUseCase: viewModel.getProfileUseCase
      )
    case .home:
      // TODO: - MatchingMainView
      Rectangle()
        .fill(Color.red)
    case .settings:
      // TODO: - SettingsView
      Rectangle()
        .fill(Color.blue)
    }
  }
}

#Preview {
  HomeView(getProfileUseCase: UseCaseFactory.createGetProfileUseCase())
}
