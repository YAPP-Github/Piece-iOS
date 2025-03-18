//
//  ValueTalkView.swift
//  PreviewProfile
//
//  Created by summercat on 1/5/25.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct ValueTalkView: View {
  @State var viewModel: ValueTalkViewModel
  @State private var contentOffset: CGFloat = 0
  @Environment(Router.self) private var router: Router
  
  private let images: [Image] = [
    DesignSystemAsset.Images.illustPuzzle01.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle02.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle03.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle04.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle05.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle06.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle07.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle08.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle09.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle10.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle11.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle12.swiftUIImage,
    DesignSystemAsset.Images.illustPuzzle13.swiftUIImage,
  ]
  
  init(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        nickname: nickname,
        description: description,
        imageUri: imageUri,
        getProfileValueTalksUseCase: getProfileValueTalksUseCase
      )
    )
  }
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: viewModel.navigationTitle,
        titleColor: .grayscaleBlack,
        rightButton: Button {
          router.popToRoot()
        } label: {
          DesignSystemAsset.Icons.close32.swiftUIImage
        },
        backgroundColor: .grayscaleWhite
      )
      .overlay(alignment: .bottom) {
        Divider(weight: .normal, isVertical: false)
      }
      
      if viewModel.isNameViewVisible {
        BasicInfoNameView(
          shortIntroduction: viewModel.description,
          nickname: viewModel.nickname
        )
        .padding(20)
        .background(Color.grayscaleWhite)
        .transition(.move(edge: .top).combined(with: .opacity))
      }
      
      ObservableScrollView(
        contentOffset: Binding(get: {
          viewModel.contentOffset
        }, set: { offset in
          viewModel.handleAction(.contentOffsetDidChange(offset))
        }),
        content: {
          talkCards
        })
      .scrollIndicators(.never)
      .padding(.horizontal, 20)
    }
    .toolbar(.hidden)
    .background(Color.grayscaleLight3)
    .animation(.easeOut(duration: 0.3), value: viewModel.isNameViewVisible)
    .overlay(alignment: .bottom) {
      buttons
    }
    .fullScreenCover(isPresented: $viewModel.isPhotoViewPresented) {
      PreviewProfilePhotoView(uri: viewModel.photoUri)
    }
  }
  
  private var talkCards: some View {
    VStack(spacing: 20) {
      ForEach(
        Array(zip(viewModel.valueTalks.indices, viewModel.valueTalks)),
        id: \.0
      ) { index, valueTalk in
        ValueTalkCard(
          topic: valueTalk.topic,
          summary: valueTalk.summary,
          answer: valueTalk.answer,
          image: images[index % images.count]
        )
      }
      Spacer()
        .frame(height: 64)
    }
    .padding(.top, 20)
    .padding(.bottom, 60)
  }
  
  // MARK: - 하단 버튼
  
  private var buttons: some View {
    HStack(alignment: .center, spacing: 8) {
      photoButton
      Spacer()
      backButton
      nextButton
    }
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .background(Color.grayscaleLight3)
  }
  
  private var photoButton: some View {
    CircleButton(
      type: .outline,
      icon: DesignSystemAsset.Icons.photoLine32.swiftUIImage
    ) {
      viewModel.handleAction(.didTapPhotoButton)
    }
  }
  
  private var backButton: some View {
    CircleButton(
      type: .solid_primary,
      icon: DesignSystemAsset.Icons.arrowLeft32.swiftUIImage,
      action: { router.pop() }
    )
  }
  
  private var nextButton: some View {
    CircleButton(
      type: .disabled,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: { }
    )
  }
  
  private func bottomSheetContentRow(
    text: String,
    tapAction: @escaping () -> Void
  ) -> some View {
    Button {
      tapAction()
    } label: {
      Text(text)
        .pretendard(.body_M_M)
        .foregroundStyle(Color.grayscaleBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
  }
}
