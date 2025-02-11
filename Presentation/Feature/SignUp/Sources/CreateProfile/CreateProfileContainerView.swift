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
    getValueTalksUseCase: GetValueTalksUseCase,
    createProfileUseCase: CreateProfileUseCase
  ) {
    _viewModel = .init(
      .init(
        getValueTalksUseCase: getValueTalksUseCase,
        createProfileUseCase: createProfileUseCase
      )
    )
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.presentedStep) {
      Rectangle() // TODO: - 프로필 기본정보 화면으로 변경
        .navigationDestination(for: CreateProfileContainerViewModel.Step.self) { step in
          switch step {
          case .valueTalk:
            ValueTalkView(
              profileCreator: viewModel.profileCreator,
              getValueTalksUseCase: viewModel.getValueTalksUseCase,
              didTapBackButton: { viewModel.presentedStep.removeLast() },
              didTapNextButton: { viewModel.presentedStep.append(.valuePick) }
            )
            
          default: EmptyView()
          }
        }
    }
  }
}
