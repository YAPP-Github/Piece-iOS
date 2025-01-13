//
//  ValuePickView.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

import DesignSystem
import SwiftUI

struct ValuePickView: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 20
    static let accepetButtonText = "매칭 수락하기"
    static let denyButtonText = "매칭 거절하기"
  }
  
  @State var viewModel: ValuePickViewModel
  @State private var contentOffset: CGFloat = 0
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: viewModel.navigationTitle,
        titleColor: .grayscaleBlack,
        rightButtonTap: {
          viewModel.handleAction(.didTapCloseButton)
        },
        backgroundColor: .grayscaleWhite
      )
      .overlay(alignment: .bottom) {
        Divider(weight: .normal, isVertical: false)
      }
      
      if viewModel.isNameViewVisible {
        BasicInfoNameView(
          description: viewModel.description,
          nickname: viewModel.nickname
        ) {
          viewModel.handleAction(.didTapMoreButton)
        }
        .padding(20)
        .background(Color.grayscaleWhite)
        .transition(.move(edge: .top).combined(with: .opacity))
      }
      
      tabs
      
      ObservableScrollView(
        contentOffset: Binding(get: {
          viewModel.contentOffset
        }, set: { offset in
          viewModel.handleAction(.contentOffsetDidChange(offset))
        })) {
          pickCards
          
          PCTextButton(content: Constant.denyButtonText)
            .onTapGesture {
              viewModel.handleAction(.didTapDenyButton)
            }
          
          Spacer()
            .frame(height: 60)
        }
        .scrollIndicators(.never)
        .background(Color.grayscaleLight3)
      
      bottomButtons
    }
  }
  
  // MARK: - 탭
  
  private var tabs: some View {
    ZStack(alignment: .bottom) {
      HStack(spacing: 0) {
        ForEach(viewModel.tabs) { tab in
          PCMiniTab(isSelected: viewModel.selectedTab == tab) {
            switch tab {
            case .all:
              Text(tab.description)
            case .same:
              HStack(spacing: 6) {
                Text(tab.description)
                Text(7.description) // TODO: - API 확인 후 수정
              }
            case .different:
              HStack(spacing: 6) {
                Text(tab.description)
                Text(3.description) // TODO: - API 확인 후 수정
              }
            }
          }
          .onTapGesture {
            withAnimation {
              viewModel.handleAction(.didSelectTab(tab))
            }
          }
        }
      }
      
      GeometryReader { geometry in
        let tabWidth = geometry.size.width / CGFloat(viewModel.tabs.count)
        let offset = tabWidth * CGFloat(viewModel.tabs.firstIndex(of: viewModel.selectedTab) ?? 0)
        Rectangle()
          .frame(width: tabWidth, height: 2)
          .foregroundStyle(Color.grayscaleBlack)
          .offset(x: offset)
          .animation(.spring, value: viewModel.selectedTab)
      }
      .frame(height: 2)
    }
    .frame(height: 48)
    .background(Color.grayscaleWhite)
  }
  
  // MARK: - Pick Card
  
  private var pickCards: some View {
    VStack(spacing: 20) {
      ForEach(viewModel.displayedValuePicks) { valuePick in
        ValuePickCard(valuePick: valuePick)
      }
    }
    .padding(.horizontal, Constant.horizontalPadding)
    .padding(.top, 20)
    .padding(.bottom, 60)
  }
  
  // MARK: - 하단 버튼
  
  private var bottomButtons: some View {
    HStack(alignment: .center, spacing: 8) {
      CircleButton(
        type: .outline,
        icon: DesignSystemAsset.Icons.photoLine32.swiftUIImage
      ) {
        viewModel.handleAction(.didTapPhotoButton)
      }
      
      Spacer()
      
      CircleButton(
        type: .solid,
        icon: DesignSystemAsset.Icons.arrowLeft32.swiftUIImage
      ) {
        viewModel.handleAction(.didTapPreviousButton)
      }
      
      RoundedButton(
        type: .solid,
        buttonText: Constant.accepetButtonText,
        icon: nil,
        rounding: true,
        action: { viewModel.handleAction(.didTapAcceptButton) }
      )
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .padding(.bottom, 10)
    .background(Color.grayscaleLight3)
  }
}

#Preview {
  ValuePickView(
    viewModel: ValuePickViewModel(
      description: "음악과 요리를 좋아하는",
      nickname: "수줍은 수달",
      valuePicks: [
        ValuePickModel(
          id: 0,
          category: "음주",
          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
          answers: [
            ValuePickAnswerModel(
              id: 1,
              content: "함께 술을 즐기고 싶어요",
              isSelected: false
            ),
            ValuePickAnswerModel(
              id: 2,
              content: "같이 술을 즐길 수 없어도 괜찮아요",
              isSelected: true
            ),
          ],
          isSame: true
        ),
        ValuePickModel(
          id: 1,
          category: "음주",
          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
          answers: [
            ValuePickAnswerModel(
              id: 1,
              content: "함께 술을 즐기고 싶어요",
              isSelected: true
            ),
            ValuePickAnswerModel(
              id: 2,
              content: "같이 술을 즐길 수 없어도 괜찮아요",
              isSelected: false
            ),
          ],
          isSame: true
        ),
        ValuePickModel(
          id: 2,
          category: "음주",
          question: "연인과 함께 술을 마시는 것을 좋아하나요?",
          answers: [
            ValuePickAnswerModel(
              id: 1,
              content: "함께 술을 즐기고 싶어요",
              isSelected: true
            ),
            ValuePickAnswerModel(
              id: 2,
              content: "같이 술을 즐길 수 없어도 괜찮아요",
              isSelected: false
            ),
          ],
          isSame: false
        )
      ]
    )
  )
}
