//
//  CreateProfileContainerViewModel.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import Entities
import Observation
import UseCases

@Observable
final class CreateProfileContainerViewModel {
  enum Action {
    case didTapCreateProfileButton
  }
  
  enum Step {
    case basicInfo
    case valueTalk
    case valuePick
  }
  
  var presentedStep: [Step] = []
  let profileCreator = ProfileCreator()
  let checkNicknameUseCase: CheckNicknameUseCase
  let uploadProfileImageUseCase: UploadProfileImageUseCase
  let getValueTalksUseCase: GetValueTalksUseCase
  let getValuePicksUseCase: GetValuePicksUseCase
  
  private let createProfileUseCase: CreateProfileUseCase
  private(set) var currentStep: Step = .basicInfo
  private(set) var isProfileCreated: Bool = false
  private(set) var error: Error?
  
  init(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase,
    createProfileUseCase: CreateProfileUseCase
  ) {
    self.checkNicknameUseCase = checkNicknameUseCase
    self.uploadProfileImageUseCase = uploadProfileImageUseCase
    self.getValueTalksUseCase = getValueTalksUseCase
    self.getValuePicksUseCase = getValuePicksUseCase
    self.createProfileUseCase = createProfileUseCase
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
    Task {
      do {
        let profile = profileCreator.createProfile()
        let response = try await createProfileUseCase.execute(profile: profile)
        
        isProfileCreated = true
        error = nil
      } catch {
        self.error = error
        print(error)
      }
    }
  }
}
