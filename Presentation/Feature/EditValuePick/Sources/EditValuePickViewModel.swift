//
// EditValuePickViewModel.swift
// EditValuePick
//
// Created by summercat on 2025/02/12.
//

import Entities
import Observation
import UseCases

@Observable
final class EditValuePickViewModel {
  enum Action {
    case updateValuePick(ValuePickModel)
  }
  
  var valuePicks: [ValuePickModel] = []
  var isEditing: Bool = false
  var isEdited: Bool = false
  
  private(set) var initialValuePicks: [ValuePickModel] = []
  private let getMatchValuePicksUseCase: GetMatchValuePicksUseCase
  
  init(getMatchValuePicksUseCase: GetMatchValuePicksUseCase) {
    self.getMatchValuePicksUseCase = getMatchValuePicksUseCase
    
    Task {
      await fetchValuePicks()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case let .updateValuePick(model):
      if let index = valuePicks.firstIndex(where: { $0.id == model.id }) {
        valuePicks[index] = model
      }
    }
  }
  
  private func fetchValuePicks() async {
    do {
      let valuePicks = try await getMatchValuePicksUseCase.execute()
      initialValuePicks = valuePicks
      self.valuePicks = valuePicks
      print(valuePicks)
    } catch {
      print(error)
    }
  }
}
