//
// OnboardingView.swift
// Onboarding
//
// Created by summercat on 2025/02/12.
//

import DesignSystem
import SwiftUI
import Router

struct OnboardingView: View {
  @State var viewModel = OnboardingViewModel()
  @Environment(Router.self) var router

  var body: some View {
    VStack {
      topBar
      content
      Spacer()
      
      Pagenation(
        totalCount: viewModel.onboardingContent.count,
        currentIndex: viewModel.contentTabIndex
      )
      bottomButton
    }
    .frame(maxHeight: .infinity)
    .background(Color.grayscaleWhite)
  }
  
  private var topBar: some View {
    HStack(alignment: .center) {
      DesignSystemAsset.Images.typeface.swiftUIImage
      Spacer()
      PCTextButton(content: "건너뛰기")
        .opacity(viewModel.isSkipButtonVisible ? 1 : 0)
        .onTapGesture {
          // TODO: - 건너뛰기 버튼 액션 확인
        }
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
  }
  
  private var content: some View {
    TabView(selection: $viewModel.contentTabIndex) {
      ForEach(
        Array(viewModel.onboardingContent.enumerated()),
        id: \.offset
      ) { index, content in
        tab(content: content)
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
  
  private func tab(content: OnboardingContent) -> some View {
    VStack(alignment: .center) {
      content.image
        .frame(width: 300, height: 300)
      
      VStack(alignment: .leading, spacing: 12) {
        Text(content.title)
          .pretendard(.heading_L_SB)
          .foregroundStyle(Color.grayscaleBlack)
        
        Text(content.description)
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleDark3)
      }
      .frame(width: 320, alignment: .leading)
    }
    .frame(maxWidth: .infinity)
  }
  
  private var bottomButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: viewModel.isLastTab ? "시작하기" : "다음",
      width: .maxWidth
    ) {
      withAnimation {
        // TODO: - tabIndex에 따라 action 다름
        if viewModel.isLastTab {
          // TODO: - 간편 로그인 화면으로 이동
          // router.push(to: <#T##Route#>)
        } else {
          viewModel.handleAction(.didTapNextButton)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .padding(.bottom, 10)
  }
}

#Preview {
  OnboardingView()
    .environment(Router())
}
