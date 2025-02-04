//
//  TabBarView.swift
//  DesignSystem
//
//  Created by eunseou on 12/28/24.
//

import Observation
import SwiftUI

// MARK: - 탭바 뷰
public struct TabBarView: View {
  @State private var viewModel: TabBarViewModel
  
  public init(
    viewModel: TabBarViewModel
  ) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Button {
          print("프로필")
          viewModel.selectedTab = .profile
        } label: {
          TabBarButton(
            tabBarImage: .profile32,
            tabBarTitle: "프로필",
            isSelected: viewModel.selectedTab == .profile
          )
        }
        Spacer()
        Button {
          print("홈")
          viewModel.selectedTab = .home
        } label: {
          Image(.btnMatch)
            .offset(y: -12)
        }
        Spacer()
        Button {
          print("설정")
          viewModel.selectedTab = .settings
        } label: {
          TabBarButton(
            tabBarImage: .setting32,
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

// MARK: - 탭바 뷰모델 (임시)
@Observable
public class TabBarViewModel {
  public var selectedTab: Tab = .home
  
  public init() { }
  
  public enum Tab {
    case profile
    case home
    case settings
  }
}

// MARK: - 탭바 버튼
public struct TabBarButton: View {
  public init(
    tabBarImage: ImageResource,
    tabBarTitle: String,
    isSelected: Bool
  ) {
    self.tabBarImage = tabBarImage
    self.tabBarTitle = tabBarTitle
    self.isSelected = isSelected
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Image(tabBarImage)
        .renderingMode(.template)
      Text(tabBarTitle)
        .pretendard(.caption_M_M)
    }
    .foregroundColor(isSelected ? .primaryDefault : .grayscaleDark3)
  }
  
  private let tabBarImage: ImageResource
  private let tabBarTitle: String
  private let isSelected: Bool
}


// MARK: - Preivew
#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    TabBarView(viewModel: TabBarViewModel())
  }
}
