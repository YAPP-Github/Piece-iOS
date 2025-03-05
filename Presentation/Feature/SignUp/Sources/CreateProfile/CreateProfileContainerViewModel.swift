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
    case updateValuePick(ProfileValuePickModel)
    case updateValueTalks([ValueTalkModel])
  }
  
  var currentStep: CreateProfileStep = .basicInfo
  
  let profileCreator = ProfileCreator()
  let checkNicknameUseCase: CheckNicknameUseCase
  let uploadProfileImageUseCase: UploadProfileImageUseCase
  let getValueTalksUseCase: GetValueTalksUseCase
  let getValuePicksUseCase: GetValuePicksUseCase
  
  private(set) var profile: ProfileModel?
  private(set) var valueTalks: [ValueTalkModel] = []
  private(set) var valuePicks: [ProfileValuePickModel] = []
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
    
    Task {
      await fetchInitialData()
    }
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
      
    case let .updateValuePick(updatedPick):
      if let index = valuePicks.firstIndex(where: { $0.id == updatedPick.id }) {
        valuePicks[index] = updatedPick
        print("📌 ContainerViewModel - updateValuePick: ID=\(updatedPick.id), selectedAnswer=\(String(describing: updatedPick.selectedAnswer))")
      }
      
    case let .updateValueTalks(updatedTalks):
      self.valueTalks = updatedTalks
      print("📌 ContainerViewModel - updateValueTalks: \(updatedTalks.count)개 업데이트")
    }
  }
  
  @MainActor
  private func fetchInitialData() async {
    do {
      async let talks = getValueTalksUseCase.execute()
      async let picks = getValuePicksUseCase.execute()
      
      let (fetchedTalks, fetchedPicks) = try await (talks, picks)
      self.valueTalks = fetchedTalks
      self.valuePicks = fetchedPicks.map {
        ProfileValuePickModel(
          id: $0.id,
          category: $0.category,
          question: $0.question,
          answers: $0.answers,
          selectedAnswer: nil
        )
      }
      error = nil
      print("📌 ContainerViewModel - 데이터 초기 로드 완료")
    } catch {
      self.error = error
      print(error)
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
    profileCreator.updateValuePicks(valuePicks)
    profile = profileCreator.createProfile()
  }
}
