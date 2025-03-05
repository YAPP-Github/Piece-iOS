//
//  TabBarView.swift
//  DesignSystem
//
//  Created by eunseou on 12/28/24.
//

import DesignSystem
import SwiftUI

// MARK: - 탭바 뷰
struct TabBarView: View {
  @State private var viewModel: TabBarViewModel
  
  init(
    viewModel: TabBarViewModel
  ) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Button {
          print("프로필")
          viewModel.selectedTab = .profile
        } label: {
          TabBarButton(
            tabBarImage: DesignSystemAsset.Icons.profile32.swiftUIImage,
            tabBarTitle: "프로필",
            isSelected: viewModel.selectedTab == .profile
          )
          .disabled(viewModel.isProfileTabDisabled)
        }
        Spacer()
        Button {
          print("홈")
          viewModel.selectedTab = .home
        } label: {
          DesignSystemAsset.Icons.btnMatch.swiftUIImage
            .offset(y: -12)
        }
        Spacer()
        Button {
          print("설정")
          viewModel.selectedTab = .settings
        } label: {
          TabBarButton(
            tabBarImage: DesignSystemAsset.Icons.setting32.swiftUIImage,
            tabBarTitle: "설정",
            isSelected: viewModel.selectedTab == .settings
          )
        }
        Spacer()
      }
      .frame(height: 89)
      .background(Color.white)
    }
  }
}

// MARK: - Preivew
#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    TabBarView(viewModel: TabBarViewModel())
  }
}
