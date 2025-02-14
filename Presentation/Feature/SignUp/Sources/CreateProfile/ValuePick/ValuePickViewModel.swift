//
//  ValuePickViewModel.swift
//  SignUp
//
//  Created by summercat on 2/10/25.
//

import Entities
import Observation
import UseCases

@Observable
final class ValuePickViewModel {
  var valuePicks: [ProfileValuePickModel] = []
  
  enum Action {
    case didTapCreateProfileButton
    case updateValuePick(ProfileValuePickModel)
  }
  
  let profileCreator: ProfileCreator
  var showToast: Bool = false
  
  private let getValuePicksUseCase: GetValuePicksUseCase
  
  init(
    profileCreator: ProfileCreator,
    getValuePicksUseCase: GetValuePicksUseCase
  ) {
    self.profileCreator = profileCreator
    self.getValuePicksUseCase = getValuePicksUseCase
    
    Task {
      await fetchValuePicks()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapCreateProfileButton:
      let isValid = valuePicks.allSatisfy { $0.selectedAnswer != nil }
      if isValid {
        profileCreator.updateValuePicks(valuePicks)
      } else {
        showToast = true
      }
      
    case let .updateValuePick(model):
      if let index = valuePicks.firstIndex(where: { $0.id == model.id }) {
        valuePicks[index] = model
      }
    }
  }
  
  private func fetchValuePicks() async {
    do {
      let valuePicks = try await getValuePicksUseCase.execute()
      self.valuePicks = valuePicks.map {
        ProfileValuePickModel(
          id: $0.id,
          category: $0.category,
          question: $0.question,
          answers: $0.answers,
          selectedAnswer: nil
        )
      }
    } catch {
      print(error)
    }
  }
}
