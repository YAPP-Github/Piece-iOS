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

enum CreateProfileStep: Hashable {
  case basicInfo
  case valueTalk
  case valuePick
}

@Observable
final class CreateProfileContainerViewModel {
  enum Action {
    case didTapCreateProfileButton
  }
  
  var navigationPath = NavigationPath()
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
    case .didTapCreateProfileButton:
      if profileCreator.isProfileValid() {
        createProfile()
      }
    }
  }
    
  private func createProfile() {
    profile = profileCreator.createProfile()
  }
}
