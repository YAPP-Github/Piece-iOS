//
//  VerifingContactView.swift
//  Login
//
//  Created by eunseou on 1/11/25.
//

import SwiftUI
import DesignSystem

struct VerifingContactView: View {
  @State var viewModel: VerifingContactViewModel
  @FocusState private var isFocused: Bool
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 104)
      
      VStack(alignment: .leading, spacing: 12) {
        Text("휴대폰 번호")
          .foregroundStyle(Color.primaryDefault) +
        Text("로\n인증을 진행해 주세요")
        Text("신뢰도 높은 매칭과 안전한 커뮤니티를 위해\n휴대폰 번호로 인증해 주세요.")
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleDark3)
      }
      .pretendard(.heading_L_SB)
      .padding(.top, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
        .frame(height: 68)
      
      VStack(spacing: 32) {
        PCTextField(
          title: "휴대폰 번호",
          text: $viewModel.phoneNumber,
          focusState: $isFocused,
          focusField: true
        )
        .infoText("- 없이 숫자만 입력해주세요")
        .withButton(
          RoundedButton(
            type: viewModel.phoneNumberTextfieldButtonType,
            buttonText: viewModel.recivedCertificationNumberButtonText,
            action: {
              viewModel.handleAction(.reciveCertificationNumber)
            }
          ),
          width: viewModel.recivedCertificationNumberButtonWidth
        )
        .onChange{ newValue in
          viewModel.phoneNumber = newValue.filter { $0.isNumber }
        }
        .textContentType(.telephoneNumber)
        
        
        if viewModel.showVerificationField {
          PCTextField(
            title: "인증번호",
            text: $viewModel.verificationCode,
            focusState: $isFocused,
            focusField: true
          )
          .infoText("어떤 경우에도 타인에게 공유하지 마세요")
          .rightText(viewModel.timerText, textColor: .primaryDefault)
          .withButton(
            RoundedButton(
              type: viewModel.verificationCodeTextfieldButtonType,
              buttonText: "확인",
              action: {
                viewModel.handleAction(.checkCertificationNumber)
              }
            )
          )
        }
      }
      Spacer()
      
      RoundedButton(
        type: viewModel.nextButtonType,
        buttonText: "다음",
        icon: nil,
        action: {
          viewModel.handleAction(.tapNextButton)
        }
      )
    }
    .padding(.bottom, 10)
    .padding(.horizontal, 20)
    .background(Color.grayscaleWhite)
  }
}

#Preview {
  VerifingContactView(
    viewModel: VerifingContactViewModel(
      phoneNumber: "01012345678",
      verificationCode: ""
    )
  )
}
