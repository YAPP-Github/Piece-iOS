//
//  CreateProfileContainerViewModel.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import Entities
import Observation
import SwiftUI
import UseCases

@Observable
final class CreateProfileContainerViewModel {
  enum CreateProfileStep: Hashable {
    case basicInfo
    case valueTalk
    case valuePick
  }

  enum Action {
    case didTapBackButton
    case didTapNextButton
    case didTapCreateProfileButton
  }
  
  var currentStep: CreateProfileStep = .basicInfo
  let profileCreator = ProfileCreator()
  let checkNicknameUseCase: CheckNicknameUseCase
  let uploadProfileImageUseCase: UploadProfileImageUseCase
  let getValueTalksUseCase: GetValueTalksUseCase
  let getValuePicksUseCase: GetValuePicksUseCase
  
  private(set) var profile: ProfileModel?
  private(set) var error: Error?
  
  init(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase
  ) {
    self.checkNicknameUseCase = checkNicknameUseCase
    self.uploadProfileImageUseCase = uploadProfileImageUseCase
    self.getValueTalksUseCase = getValueTalksUseCase
    self.getValuePicksUseCase = getValuePicksUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapBackButton:
      moveToPreviousStep()
      
    case .didTapNextButton:
      moveToNextStep()
      
    case .didTapCreateProfileButton:
      if profileCreator.isProfileValid() {
        createProfile()
      }
    }
  }
  
  private func moveToPreviousStep() {
    switch currentStep {
    case .basicInfo: break
    case .valueTalk: currentStep = .basicInfo
    case .valuePick: currentStep = .valueTalk
    }
  }
  
  private func moveToNextStep() {
    switch currentStep {
    case .basicInfo: currentStep = .valueTalk
    case .valueTalk: currentStep = .valuePick
    case .valuePick: break
    }
  }
    
  private func createProfile() {
    profile = profileCreator.createProfile()
  }
}
