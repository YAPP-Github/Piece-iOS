//
//  SwiftUIView.swift
//  SignUp
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import DesignSystem
import Router

struct CompleteSignUpView: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 20
    static let bottonPadding: CGFloat = 10
    static let nextButtonText = "프로필 생성하기"
  }
  
  @State var viewModel: CompleteSignUpViewModel
 // @Environment(Router.self) private var router: Router
  
  var body: some View {
    ZStack {
      Color.grayscaleWhite.ignoresSafeArea()
      VStack(alignment: .center, spacing: 0) {
        title
        
        Rectangle() // 일러스트 (임시)
          .fill(Color.blue)
          .frame(width: 240, height: 240)
        
        Spacer()
        
        nextButton
      }
      .padding(.horizontal, Constant.horizontalPadding)
      .padding(.bottom, Constant.bottonPadding)
    }
  }
  
  private var title: some View {
    VStack(alignment: .leading) {
      Text("Piece")
        .foregroundStyle(Color.primaryDefault) +
      Text("에 가입하신 것을\n환영해요!")
    }
    .pretendard(.heading_L_SB)
    .foregroundStyle(Color.grayscaleBlack)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom, 120)
    .padding(.top, 80)
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: Constant.nextButtonText,
      width: .maxWidth,
      action: {
        viewModel.handleAction(.tapNextButton)
        // TODO: - 추후 화면 연결
        // router.push(to: )
      }
    )
  }
}

#Preview {
  CompleteSignUpView(viewModel: CompleteSignUpViewModel())
}
