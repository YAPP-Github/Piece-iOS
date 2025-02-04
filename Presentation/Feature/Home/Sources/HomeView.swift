//
// HomeView.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import MatchingMain
import SwiftUI

struct HomeView: View {
  @State var viewModel: HomeViewModel

  var body: some View {
    ZStack {
      content
      TabBarView(viewModel: viewModel.tabbarViewModel)
    }
  }
  
  private var content: some View {
    switch viewModel.tabbarViewModel.selectedTab {
    case .profile:
      // TODO: - ProfileView
      Rectangle()
        .fill(Color.yellow)
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
  HomeView(viewModel: HomeViewModel())
}
