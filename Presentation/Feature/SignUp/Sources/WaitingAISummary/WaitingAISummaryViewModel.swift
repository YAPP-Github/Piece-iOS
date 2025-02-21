//
//  WaitingAISummaryViewModel.swift
//  SignUp
//
//  Created by summercat on 2/16/25.
//

import Entities
import Observation
import UseCases

@Observable
final class WaitingAISummaryViewModel {
  enum Action {
    case onAppear
  }
  
  init(
    profile: ProfileModel,
    createProfileUseCase: CreateProfileUseCase
  ) {
    self.profile = profile
    self.createProfileUseCase = createProfileUseCase
  }
  
  private(set) var isCreatingSummary: Bool = true
  
  private let profile: ProfileModel
  private let createProfileUseCase: CreateProfileUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      createAISummary()
    }
  }
  
  private func createAISummary() {
    Task {
      do {
        let _ = try await createProfileUseCase.execute(profile: profile)
        isCreatingSummary = false
      } catch {
        print(error)
      }
    }
  }
}
