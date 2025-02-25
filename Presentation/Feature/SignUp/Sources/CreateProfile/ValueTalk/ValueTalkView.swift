//
//  ValueTalkView.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import DesignSystem
import Entities
import Router
import SwiftUI
import UseCases

struct ValueTalkView: View {
  @Bindable var viewModel: ValueTalkViewModel
  @Environment(Router.self) private var router: Router
  var didTapNextButton: () -> Void

  init(
    profileCreator: ProfileCreator,
    initialValueTalks: [ValueTalkModel],
    didTapNextButton: @escaping () -> Void
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        profileCreator: profileCreator,
        initialValueTalks: initialValueTalks
      )
    )
    self.didTapNextButton = didTapNextButton
  }

  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: 0) {
        ScrollView {
          content
        }
        
        buttonArea
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }

  private var content: some View {
    VStack(spacing: 0) {
      title
      valueTalks
      Spacer()
        .frame(height: 60)
    }
    .frame(maxWidth: .infinity)
  }

  private var title: some View {
    VStack(spacing: 12) {
      Text("가치관 Talk,\n당신의 이야기를 들려주세요")
        .pretendard(.heading_L_SB)
        .foregroundStyle(Color.grayscaleBlack)
        .frame(maxWidth: .infinity, alignment: .leading)

      Text("AI 요약으로 내용을 더 잘 이해할 수 있도록 도와드려요.\n프로필 생성 후, '프로필-가치관 Talk'에서 확인해보세요!")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    .padding(.horizontal, 20)
    .padding(.top, 20)
    .padding(.bottom, 16)
  }

  private var valueTalks: some View {
    ForEach(
      Array(zip(viewModel.cardViewModels.indices, viewModel.cardViewModels)),
      id: \.0
    ) { index, valueTalk in
      ValueTalkCard(viewModel: Binding(
        get: { viewModel.cardViewModels[index] },
        set: { viewModel.cardViewModels[index] = $0 }) )
      if index < viewModel.valueTalks.count - 1 {
        Divider(weight: .thick, isVertical: false)
      }
    }
  }

  private var buttonArea: some View {
    RoundedButton(
      type: .solid,
      buttonText: "다음",
      width: .maxWidth
    ) {
      viewModel.handleAction(.didTapNextButton)
      didTapNextButton()
    }
    .padding(.top, 12)
    .padding(.horizontal, 20)
    .background(Color.grayscaleWhite)
  }
}
