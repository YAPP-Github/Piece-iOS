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
  enum Field: Hashable {
    case valueTalkEditor(Int)
  }
  
  @Bindable var viewModel: ValueTalkViewModel
  @Environment(Router.self) private var router: Router
  @FocusState private var focusField: Field?
  var didTapBottomButton: () -> Void

  init(
    profileCreator: ProfileCreator,
    initialValueTalks: [ValueTalkModel],
    didTapBottomButton: @escaping () -> Void
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        profileCreator: profileCreator,
        initialValueTalks: initialValueTalks
      )
    )
    self.didTapBottomButton = didTapBottomButton
  }

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        Color.clear
          .contentShape(Rectangle())
          .onTapGesture {
            focusField = nil
          }
        VStack(spacing: 0) {
          ScrollView {
            content
          }
          .overlay(alignment: .bottom) {
            if viewModel.showToast {
              PCToast(icon: DesignSystemAsset.Icons.notice20.swiftUIImage, text: "모든 항목을 작성해 주세요")
                .padding(.bottom, 8)
                .onAppear {
                  withAnimation(.easeInOut(duration: 0.5)) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak viewModel] in
                      viewModel?.showToast = false
                    }
                  }
                }
            }
          }
          
          buttonArea
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)
      }
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
      ValueTalkCard(
        viewModel: Binding(
        get: { viewModel.cardViewModels[index] },
        set: { viewModel.cardViewModels[index] = $0 }),
        focusState: $focusField
      )
      if index < viewModel.valueTalks.count - 1 {
        Divider(weight: .thick, isVertical: false)
      }
    }
  }

  private var buttonArea: some View {
    RoundedButton(
      type: .solid,
      buttonText: "프로필 생성하기",
      width: .maxWidth
    ) {
      viewModel.handleAction(.didTapBottomButton)
      didTapBottomButton()
    }
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .padding(.bottom, 10)
    .background(Color.grayscaleWhite)
  }
}
