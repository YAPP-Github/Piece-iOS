//
// BasicInfoView.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import SwiftUI
import DesignSystem

struct BasicInfoView: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 20
  }
  @State var viewModel: BasicInfoViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      NavigationBar(
        title: viewModel.navigationTitle,
        rightButtonTap: {
        viewModel.handleAction(.didTapCloseButton)
      })
      
      VStack(alignment: .leading) {
        title
        Spacer()
        BasicInfoNameView(
          description: viewModel.matchingBasicInfoModel.description,
          nickname: viewModel.matchingBasicInfoModel.nickname,
          moreButtonAction: { viewModel.handleAction(.didTapMoreButton) }
        )
      }
      .padding(.horizontal, Constant.horizontalPadding)
      .padding(.vertical, 20)
      
      basicInfoCards
        .padding(.horizontal, Constant.horizontalPadding)

      buttons
        .padding(.horizontal, Constant.horizontalPadding)
    }
    .background(Color.primaryLight)
  }
  
  private var title: some View {
    Text(viewModel.title)
      .pretendard(.body_M_M)
      .foregroundStyle(Color.primaryDefault)
  }
  
  // MARK: - Basic info card
  
  private var basicInfoCards: some View {
    VStack(spacing: 4) {
      infoCardFirstRow
      infoCardSecondRow
    }
    .padding(.vertical, 12)
  }
  
  private var infoCardFirstRow: some View {
    HStack(spacing: 4) {
      ProfileCard(
        type: .matching,
        category: "나이",
        answer: { ageAnswer }
      )
      .frame(width: 144)
      
      ProfileCard(
        type: .matching,
        category: "키",
        answer: { heightAnswer }
      )
      ProfileCard(
        type: .matching,
        category: "종교",
        answer: { religionAnswer }
      )
    }
  }
  
  private var infoCardSecondRow: some View {
    HStack(spacing: 4) {
      ProfileCard(
        type: .matching,
        category: "활동 지역",
        answer: { regionAnswer }
      )
      .frame(width: 144)
      
      ProfileCard(
        type: .matching,
        category: "직업",
        answer: { jobAnswer }
      )
      ProfileCard(
        type: .matching,
        category: "흡연",
        answer: { smokingAnswer }
      )
    }
  }
  
  private var ageAnswer: some View {
    HStack(alignment: .center, spacing: 4) {
      Text("만")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleBlack)
      HStack(alignment: .center, spacing: 0) {
        Text("\(viewModel.matchingBasicInfoModel.age)")
          .pretendard(.heading_S_SB)
          .foregroundStyle(Color.grayscaleBlack)
        Text("세")
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleBlack)
      }
      Text("\(viewModel.matchingBasicInfoModel.birthYear)년생")
        .lineLimit(1)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark2)
    }
  }
  
  private var heightAnswer: some View {
    HStack(alignment: .center, spacing: 0) {
      Text(viewModel.matchingBasicInfoModel.height.description)
        .pretendard(.heading_S_SB)
        .foregroundStyle(Color.grayscaleBlack)
      Text("cm")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleBlack)
    }
  }
  
  private var religionAnswer: some View {
    Text(viewModel.matchingBasicInfoModel.religion)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private var regionAnswer: some View {
    Text(viewModel.matchingBasicInfoModel.region)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private var jobAnswer: some View {
    Text(viewModel.matchingBasicInfoModel.job)
      .lineLimit(1)
      .truncationMode(.tail)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private var smokingAnswer: some View {
    Text(viewModel.matchingBasicInfoModel.isSmoker ? "흡연" : "비흡연")
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  // MARK: - 하단 버튼
  
  private var buttons: some View {
    HStack(alignment: .center, spacing: 8) {
      Spacer()
      backButton
      nextButton
    }
    .padding(.top, 12)
  }
  
  private var backButton: some View {
    CircleButton(
      type: .disabled,
      icon: DesignSystemAsset.Icons.arrowLeft32.swiftUIImage,
      action: { }
    )
  }
  
  private var nextButton: some View {
    CircleButton(
      type: .solid,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: { }
    )
  }
}

#Preview {
  BasicInfoView(
    viewModel: BasicInfoViewModel(
      matchingBasicInfoModel:
        BasicInfoModel(
          description: "음악과 요리를 좋아하는",
          nickname: "수줍은 수달",
          age: 25,
          birthYear: 00,
          height: 180,
          religion: "무교",
          region: "세종특별자치시",
          job: "프리랜서",
          isSmoker: false
        )
    )
  )
}
