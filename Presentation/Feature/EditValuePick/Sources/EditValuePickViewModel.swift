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
    case didTapSaveButton
  }
  
  var valuePicks: [ValuePickModel] = []
  var isEditing: Bool = false
  var isEdited: Bool {
    initialValuePicks == valuePicks
  }
  
  private(set) var initialValuePicks: [ValuePickModel] = []
  private let getMatchValuePicksUseCase: GetMatchValuePicksUseCase
  private let updateMatchValuePicksUseCase: UpdateMatchValuePicksUseCase
  
  init(
    getMatchValuePicksUseCase: GetMatchValuePicksUseCase,
    updateMatchValuePicksUseCase: UpdateMatchValuePicksUseCase
  ) {
    self.getMatchValuePicksUseCase = getMatchValuePicksUseCase
    self.updateMatchValuePicksUseCase = updateMatchValuePicksUseCase
    
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
      
    case .didTapSaveButton:
      Task {
        await updateMatchValuePicks()
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
  
  private func updateMatchValuePicks() async {
    do {
      _ = try await updateMatchValuePicksUseCase.execute(valuePicks: valuePicks)
      initialValuePicks = valuePicks
      isEditing = false
    } catch {
      print(error)
    }
  }
}
