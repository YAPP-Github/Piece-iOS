//
// MatchProfileBasicView.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct MatchProfileBasicView: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 20
  }
  
  @State var viewModel: MatchProfileBasicViewModel
  @Environment(Router.self) private var router: Router
  
  init(
    getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
  ) {
    _viewModel = .init(wrappedValue: .init(getMatchProfileBasicUseCase: getMatchProfileBasicUseCase))
  }
  
  var body: some View {
    if let basicInfoModel = viewModel.basicInfoModel {
      content(basicInfoModel: basicInfoModel)
    } else {
      EmptyView()
    }
  }
  
  private func content(basicInfoModel: BasicInfoModel) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      NavigationBar(
        title: viewModel.navigationTitle,
        rightButtonTap: {
          router.popToRoot()
        })
      
      VStack(alignment: .leading) {
        title
        Spacer()
        BasicInfoNameView(
          description: basicInfoModel.description,
          nickname: basicInfoModel.nickname,
          moreButtonAction: { viewModel.handleAction(.didTapMoreButton) }
        )
      }
      .padding(.horizontal, Constant.horizontalPadding)
      .padding(.vertical, 20)
      
      basicInfoCards(basicInfoModel: basicInfoModel)
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
  
  private func basicInfoCards(basicInfoModel: BasicInfoModel) -> some View {
    VStack(spacing: 4) {
      infoCardFirstRow(basicInfoModel: basicInfoModel)
      infoCardSecondRow(basicInfoModel: basicInfoModel)
    }
    .padding(.vertical, 12)
  }
  
  private func infoCardFirstRow(basicInfoModel: BasicInfoModel) -> some View {
    HStack(spacing: 4) {
      ProfileCard(
        type: .matching,
        category: "나이",
        answer: { ageAnswer(basicInfoModel: basicInfoModel) }
      )
      .frame(width: 144)
      
      ProfileCard(
        type: .matching,
        category: "키",
        answer: { heightAnswer(basicInfoModel: basicInfoModel) }
      )
      ProfileCard(
        type: .matching,
        category: "종교",
        answer: { religionAnswer(basicInfoModel: basicInfoModel) }
      )
    }
  }
  
  private func infoCardSecondRow(basicInfoModel: BasicInfoModel) -> some View  {
    HStack(spacing: 4) {
      ProfileCard(
        type: .matching,
        category: "활동 지역",
        answer: { regionAnswer(basicInfoModel: basicInfoModel) }
      )
      .frame(width: 144)
      
      ProfileCard(
        type: .matching,
        category: "직업",
        answer: { jobAnswer(basicInfoModel: basicInfoModel) }
      )
      ProfileCard(
        type: .matching,
        category: "흡연",
        answer: { smokingAnswer(basicInfoModel: basicInfoModel) }
      )
    }
  }
  
  private func ageAnswer(basicInfoModel: BasicInfoModel) -> some View {
    HStack(alignment: .center, spacing: 4) {
      Text("만")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleBlack)
      HStack(alignment: .center, spacing: 0) {
        Text("\(basicInfoModel.age)")
          .pretendard(.heading_S_SB)
          .foregroundStyle(Color.grayscaleBlack)
        Text("세")
          .pretendard(.body_S_M)
          .foregroundStyle(Color.grayscaleBlack)
      }
      Text("\(basicInfoModel.birthYear)년생")
        .lineLimit(1)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark2)
    }
  }
  
  private func heightAnswer(basicInfoModel: BasicInfoModel) -> some View  {
    HStack(alignment: .center, spacing: 0) {
      Text(basicInfoModel.height.description)
        .pretendard(.heading_S_SB)
        .foregroundStyle(Color.grayscaleBlack)
      Text("cm")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleBlack)
    }
  }
  
  private func religionAnswer(basicInfoModel: BasicInfoModel) -> some View  {
    Text(basicInfoModel.religion)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private func regionAnswer(basicInfoModel: BasicInfoModel) -> some View  {
    Text(basicInfoModel.region)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private func jobAnswer(basicInfoModel: BasicInfoModel) -> some View  {
    Text(basicInfoModel.job)
      .lineLimit(1)
      .truncationMode(.tail)
      .pretendard(.heading_S_SB)
      .foregroundStyle(Color.grayscaleBlack)
  }
  
  private func smokingAnswer(basicInfoModel: BasicInfoModel) -> some View  {
    Text(basicInfoModel.isSmoker ? "흡연" : "비흡연")
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
      action: {
        router.push(to: .matchValueTalk)
      }
    )
  }
}

//#Preview {
//  MatchProfileBasicView(
//    viewModel: MatchProfileBasicViewModel(
//      basicInfoModel:
//        BasicInfoModel(
//          description: "음악과 요리를 좋아하는",
//          nickname: "수줍은 수달",
//          age: 25,
//          birthYear: 00,
//          height: 180,
//          religion: "무교",
//          region: "세종특별자치시",
//          job: "프리랜서",
//          isSmoker: false
//        )
//    )
//  )
//}
