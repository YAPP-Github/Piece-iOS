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
  var valuePicks: [ValuePickModel] = []
  
  enum Action {
    case didTapCreateProfileButton
    case updateValuePick(ValuePickModel)
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
      // TODO: - 모두 선택했는지 로직 처리
      let isValid = valuePicks.allSatisfy { $0.selectedAnswer != nil }
      
      if isValid {
        profileCreator.updateValuePicks(valuePicks)
      } else {
        showToast = true
      }
      return
      
    case let .updateValuePick(model):
      if let index = valuePicks.firstIndex(where: { $0.id == model.id }) {
        valuePicks[index] = model
      }
    }
  }
  
  private func fetchValuePicks() async {
    do {
      let valuePicks = try await getValuePicksUseCase.execute()
      self.valuePicks = valuePicks
    } catch {
      print(error)
    }
  }
}
