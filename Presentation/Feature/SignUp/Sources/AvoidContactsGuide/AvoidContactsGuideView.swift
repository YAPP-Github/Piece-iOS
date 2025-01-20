//
//  AvoidContactsGuideView.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import DesignSystem

struct AvoidContactsGuideView: View {
  @State var viewModel: AvoidContactsGuideViewModel
  
  var body: some View {
    VStack {
      title
      
      Rectangle() // 일러스트 (임시)
        .frame(width: 240, height: 240)
      
      Spacer()
      
      denyButton
      
      nextButton
    }
    .padding(.horizontal, 20)
    .padding(.top, 20)
    .padding(.bottom, 10)
    .navigationBarModifier {
      NavigationBar(
        title: "",
        leftButtonTap: { viewModel.handleAction(.tapBackButton) }
      )
    }
  }
  
  private var title: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("아는사람")
        .foregroundStyle(Color.primaryDefault) +
      Text("에게는\n프로필이 노출되지 않아요")
      
      Text("연락처에 등록된 번호로 가입한 사용자는\n매칭 대상에서 제외되어, 개인정보가 보호됩니다.")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
    }
    .pretendard(.heading_L_SB)
    .foregroundStyle(Color.grayscaleBlack)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom, 70)
  }
  
  private var denyButton: some View {
    PCTextButton(content: "다음에 할래요")
      .onTapGesture {
        viewModel.handleAction(.tapDenyButton)
      }
      .padding(.bottom, 20)
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: "아는사람 차단하기",
      action: { viewModel.handleAction(.tapBlockContactButton) }
    )
  }
}

#Preview {
  AvoidContactsGuideView(viewModel: AvoidContactsGuideViewModel())
}

