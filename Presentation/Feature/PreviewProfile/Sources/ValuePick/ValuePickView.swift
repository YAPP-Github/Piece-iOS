//
//  ValuePickView.swift
//  PreviewProfile
//
//  Created by summercat on 1/13/25.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct ValuePickView: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 20
  }
  
  @State var viewModel: ValuePickViewModel
  @State private var contentOffset: CGFloat = 0
  @Environment(Router.self) private var router: Router
  
  init(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValuePicksUseCase: GetProfileValuePicksUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        nickname: nickname,
        description: description,
        imageUri: imageUri,
        getProfileValuePicksUseCase: getProfileValuePicksUseCase
      )
    )
  }
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: viewModel.navigationTitle,
        titleColor: .grayscaleBlack,
        rightButtonTap: {
          router.popToRoot()
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
        })) {
          pickCards
          Spacer()
            .frame(height: 60)
        }
        .scrollIndicators(.never)
        .frame(maxWidth: .infinity)
        .background(Color.grayscaleLight3)
      
      buttons
    }
    .toolbar(.hidden)
    .fullScreenCover(isPresented: $viewModel.isPhotoViewPresented) {
      PreviewProfilePhotoView(uri: viewModel.photoUri)
    }
  }
  
  
  // MARK: - Pick Card
  
  private var pickCards: some View {
    VStack(spacing: 20) {
      ForEach(viewModel.valuePicks) { valuePick in
        ValuePickCard(valuePick: valuePick)
      }
    }
    .padding(.horizontal, Constant.horizontalPadding)
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
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .padding(.bottom, 10)
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
      icon: DesignSystemAsset.Icons.arrowLeft32.swiftUIImage
    ) {
      router.pop()
    }
  }
  
  private var nextButton: some View {
    CircleButton(
      type: .solid_primary,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: {
        router.push(
          to: .previewProfileValueTalks(
            nickname: viewModel.nickname,
            description: viewModel.description,
            imageUri: viewModel.photoUri
          )
        )
      }
    )
  }
}
