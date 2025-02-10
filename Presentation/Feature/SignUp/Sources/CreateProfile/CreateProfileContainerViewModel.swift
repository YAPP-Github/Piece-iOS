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
  }
  
  enum Step {
    case basicInfo
    case valueTalk
    case valuePick
  }
  
  var presentedStep: [Step] = []
  let profileCreator = ProfileCreator()
  private(set) var currentStep: Step = .basicInfo
  private(set) var isProfileCreated: Bool = false
  private(set) var error: Error?
  
  init(
  ) {
  }
  
  func handleAction(_ action: Action) {
    
  private func createProfile() {
    Task {
      do {
        let profile = profileCreator.createProfile()
        // TODO: - accessToken, refreshToken 저장이 필요한 경우 여기서 처리해주세요
        isProfileCreated = true
        error = nil
      } catch {
        self.error = error
        print(error)
      }
    }
  }
}
