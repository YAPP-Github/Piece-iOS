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
    ZStack(alignment: .bottom) {
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
        .padding(.top, 12)
        .padding(.bottom, 8)
        
        Spacer()
        
        Spacer()
          .frame(width: 80)
        
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
        .padding(.top, 12)
        .padding(.bottom, 8)
        
        Spacer()
      }
      .background(.white)
      
      ZStack {
          Circle()
          .fill(.primaryDefault)
          .frame(width: 80, height: 80)

          Circle()
              .strokeBorder(Color.white, lineWidth: 6)
              .frame(width: 81, height: 81)
      }
      .overlay {
        DesignSystemAsset.Icons.heartPuzzle40.swiftUIImage
      }
      .onTapGesture {
        print("홈")
        viewModel.selectedTab = .home
      }
    }
    .frame(height: 80)
  }
}

// MARK: - Preivew
#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    TabBarView(viewModel: TabBarViewModel())
  }
}
