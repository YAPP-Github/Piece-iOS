//
// BlockUserView.swift
// BlockUser
//
// Created by summercat on 2025/02/12.
//

import DesignSystem
import Router
import SwiftUI

struct BlockUserView: View {
  @State private var viewModel: BlockUserViewModel
  @Environment(Router.self) private var router
  
  init() { _viewModel = .init(wrappedValue: .init()) }
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "차단하기",
        leftButtonTap: {
          router.pop()
        }
      )
      content
    }
    .frame(maxWidth: .infinity)
    .pcAlert(isPresented: $viewModel.isBlockUserAlertPresented) {
      AlertView(
        title: {
          // TODO: - 닉네임 추가
          Text("님을\n차단하시겠습니까?")
            .pretendard(.heading_M_SB)
            .foregroundStyle(Color.grayscaleBlack)
        },
        message: "차단하면 상대방을 영영 만날 수 없게 되며,\n되돌릴 수 없습니다.",
        firstButtonText: "취소",
        secondButtonText: "차단하기"
      ) {
        viewModel.handleAction(.didTapBlockUserAlertBackButton)
      } secondButtonAction: {
        viewModel.handleAction(.didTapBlockUserAlertBlockUserButton)
      }
    }
    .pcAlert(isPresented: $viewModel.isBlockUserCompleteAlertPresented) {
      AlertView(
        title: {
          // TODO: - 닉네임 추가
          Text("님을 차단했습니다.")
            .pretendard(.heading_M_SB)
            .foregroundStyle(Color.grayscaleBlack)
        },
        message: "매칭이 즉시 종료되며,\n상대방에게 차단 사실을 알리지 않습니다.",
        secondButtonText: "홈으로"
      ) {
        viewModel.handleAction(.didTapBlockUserCompleteButton)
        router.popToRoot()
      }
    }
  }
  
  private var content: some View {
    VStack(spacing: 0) {
      title
      list
      Spacer()
      bottomButton
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
  }
  
  private var title: some View {
    VStack(alignment: .leading, spacing: 12) {
      // TODO: - 닉네임 넘겨받아서 ~~님에 추가
      Text("님을\n차단하시겠습니까?")
        .pretendard(.heading_L_SB)
        .foregroundStyle(Color.grayscaleBlack)
      
      Text("차단하면 상대방의 매칭이 즉시 종료되며,\n 상대방에게 차단 사실을 알리지 않습니다.")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 20)
  }
  
  private var list: some View {
    VStack(spacing: 0) {
      listRow(
        image: DesignSystemAsset.Icons.blockingHeart.swiftUIImage,
        text: "차단하는 즉시\n상대방과의 매칭이 종료됩니다."
      )
      Divider(weight: .normal, isVertical: false)
      
      listRow(
        image: DesignSystemAsset.Icons.blockingPuzzle.swiftUIImage,
        text: "차단된 상대와\n더 이상 매칭되지 않습니다."
      )
      Divider(weight: .normal, isVertical: false)
      
      listRow(
        image: DesignSystemAsset.Icons.blockingAlarm.swiftUIImage,
        text: "상대방에게\n차단한 사실을 알리지 않습니다."
      )
    }
    .padding(.top, 52)
  }
  
  private func listRow(image: Image, text: String) -> some View {
    HStack(alignment: .center, spacing: 12) {
      image
      Text(text)
        .pretendard(.body_M_SB)
        .foregroundStyle(Color.grayscaleBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.vertical, 16)
  }
  
  private var bottomButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: "다음",
      width: .maxWidth
    ) {
      viewModel.handleAction(.didTapBottomButton)
    }
  }
}

#Preview {
  BlockUserView()
    .environment(Router())
}
