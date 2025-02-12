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
  
  init(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase,
    createProfileUseCase: CreateProfileUseCase
  ) {
    _viewModel = .init(
      .init(
        checkNicknameUseCase: checkNicknameUseCase,
        uploadProfileImageUseCase: uploadProfileImageUseCase,
        getValueTalksUseCase: getValueTalksUseCase,
        getValuePicksUseCase: getValuePicksUseCase,
        createProfileUseCase: createProfileUseCase
      )
    )
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.presentedStep) {
      CreateBasicInfoView(
        profileCreator: viewModel.profileCreator,
        checkNicknameUseCase: viewModel.checkNicknameUseCase,
        uploadProfileImageUseCase: viewModel.uploadProfileImageUseCase
      ) // TODO: - 프로필 기본정보 화면으로 변경
        .navigationDestination(for: CreateProfileContainerViewModel.Step.self) { step in
          switch step {
          case .valueTalk:
            ValueTalkView(
              profileCreator: viewModel.profileCreator,
              getValueTalksUseCase: viewModel.getValueTalksUseCase,
              didTapBackButton: { viewModel.presentedStep.removeLast() },
              didTapNextButton: { viewModel.presentedStep.append(.valuePick) }
            )
            
          case .valuePick:
            ValuePickView(
              profileCreator: viewModel.profileCreator,
              getValuePicksUseCase: viewModel.getValuePicksUseCase,
              didTapBackButton: { viewModel.presentedStep.removeLast() },
              didTapCreateProfileButton: {
                viewModel.handleAction(.didTapCreateProfileButton)
                
                if viewModel.isProfileCreated {
                  // TODO: - AI 요약 생성중 화면으로 라우팅 처리
                }
              }
            )
            .navigationBarHidden(true)
            
          default: EmptyView()
          }
        }
    }
  }
}
