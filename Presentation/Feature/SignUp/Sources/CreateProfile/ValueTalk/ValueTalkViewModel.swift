//
//  ValueTalkViewModel.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import Entities
import Observation
import SwiftUI
import UseCases

@Observable
final class ValueTalkViewModel {
  enum Action {
    case didTapNextButton
    case updateAnswer(index: Int, answer: String)
  }
  
  let profileCreator: ProfileCreator
  var valueTalks: [ValueTalkModel] = []
  var cardViewModels: [ValueTalkCardViewModel] = []

  private let getValueTalksUseCase: GetValueTalksUseCase
  
  init(
    profileCreator: ProfileCreator,
    getValueTalksUseCase: GetValueTalksUseCase
  ) {
    self.profileCreator = profileCreator
    self.getValueTalksUseCase = getValueTalksUseCase
    
    Task {
      await fetchValueTalks()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case let .updateAnswer(index, answer):
      valueTalks[index].answer = answer
      
    case .didTapNextButton:
      for cardViewModel in cardViewModels {
        valueTalks[cardViewModel.index].answer = cardViewModel.localAnswer
      }
      profileCreator.updateValueTalks(valueTalks)
    }
  }
  
  @MainActor
  private func fetchValueTalks() async {
    do {
      let valueTalks = try await getValueTalksUseCase.execute()
      self.valueTalks = valueTalks
      cardViewModels = valueTalks.enumerated().map { index, talk in
        ValueTalkCardViewModel(model: talk, index: index)
      }
    } catch {
      print(error)
    }
  }
}
