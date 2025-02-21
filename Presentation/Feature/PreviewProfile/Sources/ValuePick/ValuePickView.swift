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
      type: .disabled,
      icon: DesignSystemAsset.Icons.arrowLeft32.swiftUIImage,
      action: { }
    )
  }
}

//#Preview {
//  ValuePickView(
//    viewModel: ValuePickViewModel(
//      description: "음악과 요리를 좋아하는",
//      nickname: "수줍은 수달",
//      valuePicks: [
//        ValuePickModel(
//          id: 0,
//          category: "음주",
//          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
//          answers: [
//            ValuePickAnswerModel(
//              id: 1,
//              content: "함께 술을 즐기고 싶어요",
//              isSelected: false
//            ),
//            ValuePickAnswerModel(
//              id: 2,
//              content: "같이 술을 즐길 수 없어도 괜찮아요",
//              isSelected: true
//            ),
//          ],
//          isSame: true
//        ),
//        ValuePickModel(
//          id: 1,
//          category: "음주",
//          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
//          answers: [
//            ValuePickAnswerModel(
//              id: 1,
//              content: "함께 술을 즐기고 싶어요",
//              isSelected: true
//            ),
//            ValuePickAnswerModel(
//              id: 2,
//              content: "같이 술을 즐길 수 없어도 괜찮아요",
//              isSelected: false
//            ),
//          ],
//          isSame: true
//        ),
//        ValuePickModel(
//          id: 2,
//          category: "음주",
//          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
//          answers: [
//            ValuePickAnswerModel(
//              id: 1,
//              content: "함께 술을 즐기고 싶어요",
//              isSelected: true
//            ),
//            ValuePickAnswerModel(
//              id: 2,
//              content: "같이 술을 즐길 수 없어도 괜찮아요",
//              isSelected: false
//            ),
//          ],
//          isSame: false
//        )
//      ]
//    )
//  )
//}
