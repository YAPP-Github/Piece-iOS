//
//  LoginView.swift
//  Login
//
//  Created by eunseou on 1/10/25.
//

import SwiftUI
import DesignSystem
import PCFoundationExtension

struct LoginView: View {
  @State var loginViewModel: LoginViewModel
  
  var body: some View {
    ZStack {
      Color.grayscaleWhite.ignoresSafeArea()
      VStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 12) {
          Text("Piece")
            .foregroundStyle(Color.primaryDefault) +
          Text("에서 마음이 통하는\n이상형을 만나보세요")
            .foregroundStyle(Color.grayscaleBlack)
          Text("서로의 빈 곳을 채우며 맞물리는 퍼즐처럼.\n서로의 가치관과 마음이 연결되는 순간을 만들어갑니다.")
            .pretendard(.body_S_M)
            .foregroundStyle(Color.grayscaleDark3)
        }
        .pretendard(.heading_L_SB)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        Rectangle() // 일러스트 (임시)
          .fill(Color.grayscaleDark1)
          .frame(width: 240, height: 240)
        
        Spacer()
        
        VStack(spacing: 10) {
          appleLoginButton
          kakaoLoginButton
          googleLoginButton
        }
      }
      .padding(.bottom, 10)
      .padding(.top, 80)
      .padding(.horizontal, 20)
    }
  }
  
  private var appleLoginButton: some View {
    loginButton(
      icon: DesignSystemAsset.Icons.apple20.swiftUIImage,
      title: "애플로 시작하기",
      titleColor: .grayscaleWhite,
      backgroundColor: .grayscaleBlack,
      action: { loginViewModel.handleAction(.tapAppleLoginButton) }
    )
  }
  
  private var kakaoLoginButton: some View {
    loginButton(
      icon: DesignSystemAsset.Icons.kakao20.swiftUIImage,
      title: "카카오로 시작하기",
      titleColor: .grayscaleBlack,
      backgroundColor: Color(hex: 0xFFE812),
      action: { loginViewModel.handleAction(.tapKakaoLoginButton) }
    )
  }
  
  private var googleLoginButton: some View {
    loginButton(
      icon: DesignSystemAsset.Icons.google20.swiftUIImage,
      title: "구글로 시작하기",
      titleColor: .grayscaleBlack,
      backgroundColor: .grayscaleWhite,
      borderColor: .grayscaleLight1,
      action: { loginViewModel.handleAction(.tapGoogleLoginButton) }
    )
  }
  
  private func loginButton(
    icon: Image,
    title: String,
    titleColor: Color,
    backgroundColor: Color,
    borderColor: Color? = nil,
    action: @escaping () -> Void
  ) -> some View {
    Button(action: action) {
      HStack(spacing: 12) {
        icon
        Text(title)
          .pretendard(.body_M_SB)
          .foregroundStyle(titleColor)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(backgroundColor)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(borderColor ?? Color.clear, lineWidth: 1)
      )
    }
  }
}

#Preview {
  LoginView(loginViewModel: LoginViewModel())
}
