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
     NavigationStack(path: $viewModel.navigationPath) {
       CreateBasicInfoView(
         profileCreator: viewModel.profileCreator,
         checkNicknameUseCase: viewModel.checkNicknameUseCase,
         uploadProfileImageUseCase: viewModel.uploadProfileImageUseCase,
         didTapNextButton: { viewModel.navigationPath.append(CreateProfileStep.valueTalk) }
       )
       .navigationDestination(for: CreateProfileStep.self) { step in
         switch step {
         case .basicInfo:
           CreateBasicInfoView(
             profileCreator: viewModel.profileCreator,
             checkNicknameUseCase: viewModel.checkNicknameUseCase,
             uploadProfileImageUseCase: viewModel.uploadProfileImageUseCase,
             didTapNextButton: { viewModel.navigationPath.append(CreateProfileStep.valueTalk) }
           )
           .toolbar(.hidden)

         case .valueTalk:
           ValueTalkView(
             profileCreator: viewModel.profileCreator,
             getValueTalksUseCase: viewModel.getValueTalksUseCase,
             didTapBackButton: { viewModel.navigationPath.removeLast() },
             didTapNextButton: { viewModel.navigationPath.append(CreateProfileStep.valuePick) }
           )
           .toolbar(.hidden)
           
         case .valuePick:
           ValuePickView(
             profileCreator: viewModel.profileCreator,
             getValuePicksUseCase: viewModel.getValuePicksUseCase,
             didTapBackButton: { viewModel.navigationPath.removeLast() },
             didTapCreateProfileButton: {
               viewModel.handleAction(.didTapCreateProfileButton)
               
               if viewModel.isProfileCreated {
                 router.setRoute(.waitingAISummary)
               }
             }
           )
           .toolbar(.hidden)
         }
       }
     }
   }
}
