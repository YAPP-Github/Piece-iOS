//
//  CreateProfileContainerViewModel.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import Entities
import Observation
import Router
import SwiftUI
import UseCases

@Observable
final class CreateProfileContainerViewModel {
  enum CreateProfileStep: Hashable {
    case basicInfo
    case valuePick
    case valueTalk
  }

  enum Action {
    case didTapBackButton
    case didTapBottomButton
    case updateValuePick(ProfileValuePickModel)
    case updateValueTalks([ValueTalkModel])
  }
  
  var currentStep: CreateProfileStep = .basicInfo
  
  let profileCreator = ProfileCreator()
  let checkNicknameUseCase: CheckNicknameUseCase
  let uploadProfileImageUseCase: UploadProfileImageUseCase
  let getValueTalksUseCase: GetValueTalksUseCase
  let getValuePicksUseCase: GetValuePicksUseCase
  
//  private(set) var profile: ProfileModel?
  private(set) var valueTalks: [ValueTalkModel] = []
  private(set) var valuePicks: [ProfileValuePickModel] = []
  private(set) var error: Error?
  private(set) var destination: Route?
  
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
      didTapBackButton()
      
    case .didTapBottomButton:
      didTapBottomButton()

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
  
  private func didTapBackButton() {
    switch currentStep {
    case .basicInfo: break
    case .valuePick: currentStep = .basicInfo
    case .valueTalk: currentStep = .valuePick
    }
  }
  
  private func didTapBottomButton() {
    switch currentStep {
    case .basicInfo: currentStep = .valuePick
    case .valuePick: currentStep = .valueTalk
    case .valueTalk: break
    }
    
    if currentStep == .valueTalk,
       profileCreator.isProfileValid() {
      createProfile()
    }
  }
    
  private func createProfile() {
    let profile = profileCreator.createProfile()
    destination = .waitingAISummary(profile: profile)
  }
}
