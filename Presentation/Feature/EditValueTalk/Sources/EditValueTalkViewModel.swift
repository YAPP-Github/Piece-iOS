//
// EditValueTalkViewModel.swift
// EditValueTalk
//
// Created by summercat on 2025/02/13.
//

import Entities
import Observation
import UseCases

@Observable
final class EditValueTalkViewModel {
  enum Action {
    case updateValueTalk(ProfileValueTalkModel)
    case didTapSaveButton
  }
  
  var valueTalks: [ProfileValueTalkModel] = []
  var cardViewModels: [EditValueTalkCardViewModel] = []
  var isEditing: Bool = false
  var isEdited: Bool {
    initialValueTalks == valueTalks
  }
  
  private(set) var initialValueTalks: [ProfileValueTalkModel] = []
  private let getProfileValueTalksUseCase: GetProfileValueTalksUseCase
  private let updateProfileValueTalksUseCase: UpdateProfileValueTalksUseCase
  
  init(
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase,
    updateProfileValueTalksUseCase: UpdateProfileValueTalksUseCase
  ) {
    self.getProfileValueTalksUseCase = getProfileValueTalksUseCase
    self.updateProfileValueTalksUseCase = updateProfileValueTalksUseCase
    
    Task {
      await fetchValueTalks()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case let .updateValueTalk(model):
      if let index = valueTalks.firstIndex(where: { $0.id == model.id }) {
        valueTalks[index] = model
      }
      
    case .didTapSaveButton:
      didTapSaveButton()
    }
  }

  private func didTapSaveButton() {
    if isEditing {
      if isEdited {
        for cardViewModel in cardViewModels {
          valueTalks[cardViewModel.index].answer = cardViewModel.localAnswer
          valueTalks[cardViewModel.index].summary = cardViewModel.localSummary
        }
        Task {
          await updateProfileValueTalks()
        }
      }
    } else {
      isEditing = true
    }
  }
  
  private func fetchValueTalks() async {
    do {
      let valueTalks = try await getProfileValueTalksUseCase.execute()
      initialValueTalks = valueTalks
      self.valueTalks = valueTalks
      print(valueTalks)
    } catch {
      print(error)
    }
  }
  
  private func updateProfileValueTalks() async {
    do {
      _ = try await updateProfileValueTalksUseCase.execute(valueTalks: valueTalks)
      initialValueTalks = valueTalks
      isEditing = false
      // TODO: - AI 요약 요청 API 호출
    } catch {
      print(error)
    }
  }
}
