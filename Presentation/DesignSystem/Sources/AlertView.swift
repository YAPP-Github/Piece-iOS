//
//  AlertView.swift
//  DesignSystem
//
//  Created by eunseou on 12/31/24.
//

import SwiftUI

public struct AlertView: View {
  public enum AlertType {
    case defaultType
    case iconType
  }
  
  public init(
    type: AlertType,
    icon: Image? = nil,
    title: String,
    message: String,
    firstButtonText: String,
    secondButtonText: String,
    firstButtonAction: @escaping () -> Void,
    secondButtonAction: @escaping () -> Void
  ) {
    self.type = type
    self.icon = icon
    self.title = title
    self.message = message
    self.firstButtonText = firstButtonText
    self.secondButtonText = secondButtonText
    self.firstButtonAction = firstButtonAction
    self.secondButtonAction = secondButtonAction
  }
  
  public var body: some View {
    VStack {
      AlertTopView(
        type: type,
        icon: icon,
        title: title,
        message: message
      )
      AlertBottomView(
        firstButtonText: firstButtonText,
        secondButtonText: secondButtonText,
        firstButtonAction: firstButtonAction,
        secondButtonAction: secondButtonAction
      )
    }
    .frame(maxWidth: 312)
    .background(
      Rectangle()
        .fill(Color.grayscaleWhite)
        .cornerRadius(12)
    )
  }
  
  private let type: AlertType
  private let icon: Image?
  private let title: String
  private let message: String
  private let firstButtonText: String
  private let secondButtonText: String
  private let firstButtonAction: () -> Void
  private let secondButtonAction: () -> Void
}

private struct AlertTopView: View {
  var body: some View {
    VStack(spacing: 8) {
      if type == .iconType, let icon {
        icon
      }
      Text(title)
        .pretendard(.body_M_SB)
        .foregroundColor(.grayscaleBlack)
      Text(message)
        .pretendard(.body_S_M)
        .foregroundColor(.grayscaleDark2)
    }
    .multilineTextAlignment(.center)
    .padding(.top, 40)
    .padding(.bottom, 12)
    .padding(.horizontal, 20)
  }
  
  let type: AlertView.AlertType
  let icon: Image?
  let title: String
  let message: String
}

private struct AlertBottomView: View {
  var body: some View {
    HStack {
      RoundedButton(
        type: .outline,
        buttonText: firstButtonText,
        icon: nil,
        height: 52,
        action: firstButtonAction
      )
      RoundedButton(
        type: .solid,
        buttonText: secondButtonText,
        icon: nil,
        height: 52,
        action: secondButtonAction
      )
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
    .padding(.top, 12)
  }
  
  let firstButtonText: String
  let secondButtonText: String
  let firstButtonAction: () -> Void
  let secondButtonAction: () -> Void
}

#Preview {
  ZStack{
    Color.grayscaleBlack.ignoresSafeArea()
    VStack{
      AlertView(
        type: .defaultType,
        title: "수줍은 수달님과의 인연을 이어가시겠습니까?",
        message: "서로 매칭을 수락하면, 연락처가 공개됩니다.",
        firstButtonText: "뒤로",
        secondButtonText: "매칭 수락하기",
        firstButtonAction: {},
        secondButtonAction: {}
      )
      AlertView(
        type: .iconType,
        icon: DesignSystemAsset.Icons.matchingModeCheck20.swiftUIImage,
        title: "수줍은 수달님과의 인연을 이어가시겠습니까?",
        message: "서로 매칭을 수락하면, 연락처가 공개됩니다.",
        firstButtonText: "label",
        secondButtonText: "label",
        firstButtonAction: {},
        secondButtonAction: {}
      )
    }
  }
}

