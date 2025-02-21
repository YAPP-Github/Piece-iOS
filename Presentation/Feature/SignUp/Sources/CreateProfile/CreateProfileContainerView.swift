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
  @Bindable var viewModel: CreateProfileContainerViewModel
  @Environment(Router.self) private var router: Router
  @Environment(\.dismiss) private var dismiss
  
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
    ZStack {
      switch viewModel.currentStep {
      case .basicInfo:
        basicInfoView
          .transition(.move(edge: .leading))
      case .valueTalk:
        valueTalkView
          .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
      case .valuePick:
        valuePickView
          .transition(.move(edge: .trailing))
      }
    }
    .animation(.easeInOut, value: viewModel.currentStep)
  }
  
  private var basicInfoView: some View {
    CreateBasicInfoView(
      profileCreator: viewModel.profileCreator,
      checkNicknameUseCase: viewModel.checkNicknameUseCase,
      uploadProfileImageUseCase: viewModel.uploadProfileImageUseCase,
      didTapNextButton: { viewModel.handleAction(.didTapNextButton) }
    )
  }
  
  private var valueTalkView: some View {
    ValueTalkView(
      profileCreator: viewModel.profileCreator,
      getValueTalksUseCase: viewModel.getValueTalksUseCase,
      didTapBackButton: { viewModel.handleAction(.didTapBackButton) },
      didTapNextButton: { viewModel.handleAction(.didTapNextButton) }
    )
  }
  
  private var valuePickView: some View {
    ValuePickView(
      profileCreator: viewModel.profileCreator,
      getValuePicksUseCase: viewModel.getValuePicksUseCase,
      didTapBackButton: { viewModel.handleAction(.didTapBackButton) },
      didTapCreateProfileButton: {
        viewModel.handleAction(.didTapCreateProfileButton)
        if let profile = viewModel.profile {
          router.setRoute(.waitingAISummary(profile: profile))
        }
      }
    )
  }
}
