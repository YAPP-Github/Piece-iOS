//
//  CreateProfileContainerView.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct CreateProfileContainerView: View {
  @Namespace private var createBasicInfo
  @Namespace private var valueTalk
  @Namespace private var valuePick
  @Bindable var viewModel: CreateProfileContainerViewModel
  @Environment(Router.self) private var router: Router
  @Environment(\.dismiss) private var dismiss // TODO: - dismiss 동작 확인
  
  private let screenWidth = UIScreen.main.bounds.width
  
  init(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase
  ) {
    _viewModel = .init(
      .init(
        checkNicknameUseCase: checkNicknameUseCase,
        uploadProfileImageUseCase: uploadProfileImageUseCase,
        getValueTalksUseCase: getValueTalksUseCase,
        getValuePicksUseCase: getValuePicksUseCase
      )
    )
  }
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "",
        leftButtonTap: { viewModel.handleAction(.didTapBackButton) }
      )
      pageIndicator
      ZStack {
        basicInfoView
          .transition(.move(edge: .leading))
          .opacity(viewModel.currentStep == .basicInfo ? 1 : 0)
          .disabled(viewModel.currentStep != .basicInfo)
        
        valueTalkView
          .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
          .opacity(viewModel.currentStep == .valueTalk ? 1 : 0)
          .disabled(viewModel.currentStep != .valueTalk)
        
        valuePickView
          .transition(.move(edge: .trailing))
          .opacity(viewModel.currentStep == .valuePick ? 1 : 0)
          .disabled(viewModel.currentStep != .valuePick)
      }
      .animation(.easeInOut, value: viewModel.currentStep)
    }
    .toolbar(.hidden)
    .pcAlert(isPresented: $viewModel.isBackButtonAlertPresented) {
      AlertView(
        icon: DesignSystemAsset.Icons.notice40.swiftUIImage,
        title: { Text("작성 중인 프로필이 사라져요!") },
        message: "지금 뒤로 가면 프로필이 저장되지 않습니다.\n계속 이어서 작성해 보세요.",
        firstButtonText: "뒤로",
        secondButtonText: "이어서 작성하기",
        firstButtonAction: { dismiss() },
        secondButtonAction: { viewModel.isBackButtonAlertPresented = false }
      )
    }
  }
  
  private var pageIndicator: some View {
    let step = viewModel.currentStep == .basicInfo
    ? PCPageIndicator.IndicatorStep.first
    : viewModel.currentStep == .valueTalk ? .second : .third

    return PCPageIndicator(
      step: step,
      width: screenWidth
    )
  }
  
  private var basicInfoView: some View {
    CreateBasicInfoView(
      profileCreator: viewModel.profileCreator,
      checkNicknameUseCase: viewModel.checkNicknameUseCase,
      uploadProfileImageUseCase: viewModel.uploadProfileImageUseCase,
      didTapNextButton: { viewModel.handleAction(.didTapNextButton) }
    )
    .id(createBasicInfo)
  }
  
  private var valueTalkView: some View {
    ValueTalkView(
      profileCreator: viewModel.profileCreator,
      initialValueTalks: viewModel.valueTalks,
      didTapNextButton: { viewModel.handleAction(.didTapNextButton) }
    )
    .id(valueTalk)
  }
  
  private var valuePickView: some View {
    ValuePickView(
      profileCreator: viewModel.profileCreator,
      initialValuePicks: viewModel.valuePicks,
      onUpdateValuePick: { updatedPick in
        viewModel.handleAction(.updateValuePick(updatedPick))
      },
      didTapCreateProfileButton: {
        viewModel.handleAction(.didTapCreateProfileButton)
        if let profile = viewModel.profile {
          router.setRoute(.waitingAISummary(profile: profile))
        }
      }
    )
    .id(valuePick)
  }
}
