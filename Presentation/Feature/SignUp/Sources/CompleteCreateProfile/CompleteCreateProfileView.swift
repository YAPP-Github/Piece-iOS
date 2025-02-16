//
//  CompleteCreateProfileView.swift
//  SignUp
//
//  Created by summercat on 2/16/25.
//

import DesignSystem
import Router
import SwiftUI

struct CompleteCreateProfileView: View {
  @Environment(Router.self) private var router
  
  var body: some View {
    VStack(alignment: .center) {
      Spacer()
        .frame(height: 60) // NavigationBar만큼 여백
      titleArea
      Spacer()
        .frame(maxHeight: .infinity)
      
      DesignSystemAsset.Images.imgProfile.swiftUIImage
        .resizable()
        .frame(width: 300, height: 300)
      
      Spacer()
        .frame(maxHeight: .infinity)
      
      buttons
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 20)
  }
  
  private var titleArea: some View {
    VStack(alignment: .leading, spacing: 12) {
      title
        
      description
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var title: some View {
    Text("프로필 생성을 마쳤습니다!")
      .pretendard(.heading_L_SB)
      .foregroundStyle(.grayscaleBlack)
  }
  
  private var description: some View {
    Text("작성 후 24시간 이내에 심사가 진행됩니다.\n생성한 프로필을 검토하며 기다려 주세요.")
      .pretendard(.body_S_M)
      .foregroundStyle(.grayscaleDark3)
  }
  
  private var buttons: some View {
    VStack(alignment: .center, spacing: 20) {
      PCTextButton(content: "홈으로")
      RoundedButton(
        type: .solid,
        buttonText: "내 프로필 확인하기",
        width: .maxWidth
      ) {
        router.setRoute(.home) // TODO: - 내 프로필 미리보기로 가도록 수정 (구현 필요)
      }
    }
    .padding(.top, 12)
  }
}

#Preview {
  CompleteCreateProfileView()
    .environment(Router())
}

