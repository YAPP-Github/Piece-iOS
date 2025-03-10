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
  
  init(
    profileCreator: ProfileCreator,
    initialValueTalks: [ValueTalkModel]
  ) {
    self.profileCreator = profileCreator
    
    if profileCreator.valueTalks.isEmpty {
      self.valueTalks = initialValueTalks
    } else {
      self.valueTalks = profileCreator.valueTalks
    }
    
    self.cardViewModels = self.valueTalks.enumerated().map { index, talk in
      ValueTalkCardViewModel(model: talk, index: index)
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
}
