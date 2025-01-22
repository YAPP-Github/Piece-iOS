//
//  PermissionRequestView.swift
//  SignUp
//
//  Created by eunseou on 1/14/25.
//

import SwiftUI
import DesignSystem

struct PermissionRequestView: View {
  @State var viewModel: PermissionRequestViewModel
  @Environment(\.dismiss) private var dismiss
  @Environment(\.scenePhase) private var scenePhase

  var body: some View {
    ZStack {
      Color.grayscaleWhite.ignoresSafeArea()
      VStack(alignment: .center, spacing: 0) {
        VStack(spacing: 16) {
          title
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.cameraLine32.swiftUIImage,
            title: "사진, 카메라",
            description: "프로필 생성 시 사진 첨부를 위해 필요해요.",
            isRequired: true
          )
          
          Divider(weight: .normal, isVertical: false)
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.alarm32.swiftUIImage,
            title: "알림",
            description: "매칭 현황 등 중요 메세지 수신을 위해 필요해요.",
            isRequired: false
          )
          
          Divider(weight: .normal, isVertical: false)
          
          PermissionItem(
            icon: DesignSystemAsset.Icons.cellLine32.swiftUIImage,
            title: "연락처",
            description: "지인을 수집하기 위해 필요해요.",
            isRequired: false
          )
        }
        
        Spacer()
        
        nextButton
      }
      .padding(.horizontal, 20)
      .padding(.top, 20)
      .padding(.bottom, 10)
    }
    .task {
       await viewModel.checkPermissions()
    }
    .onChange(of: scenePhase) {
      if scenePhase == .active {
        Task {
          await viewModel.checkPermissions()
        }
      }
    }
    .navigationBarModifier {
      NavigationBar(
        title: "",
        leftButtonTap: { viewModel.handleAction(.tapBackButton) }
      )
    }
    .onAppear {
      viewModel.setDismissAction { dismiss() }
    }
  }

  private var title: some View {
    VStack(alignment: .leading) {
      Text("편리한 Piece 이용을 위해")
      Text("아래 ") +
      Text("권한 허용")
        .foregroundStyle(Color.primaryDefault) +
      Text("이 필요해요")
    }
    .pretendard(.heading_L_SB)
    .foregroundStyle(Color.grayscaleBlack)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom, 120)
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: viewModel.nextButtonType ,
      buttonText: "다음",
      action: { viewModel.handleAction(.tapNextButton) }
    )
  }
  
  private func PermissionItem(
    icon: Image,
    title: String,
    description: String,
    isRequired: Bool
  ) -> some View {
    HStack(alignment: .center, spacing: 20) {
      icon
        .renderingMode(.template)
        .background(
          Circle()
            .foregroundStyle(Color.grayscaleLight3)
            .frame(width: 48, height: 48)
        )
      
      VStack(alignment: .leading, spacing: 4) {
        Text(title) +
        Text(isRequired ? " [필수]" : " [선택]")
        Text(description)
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleDark2)
      }
      .pretendard(.body_M_SB)
      
      Spacer()
    }
    .foregroundStyle(Color.grayscaleBlack)
  }
}


struct PermissionRequestView_Previews: PreviewProvider {
  static var previews: some View {
    PermissionRequestView(viewModel: PermissionRequestViewModel())
  }
}
