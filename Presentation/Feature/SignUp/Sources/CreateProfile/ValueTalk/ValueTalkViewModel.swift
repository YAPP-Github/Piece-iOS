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
  
  private func fetchValueTalks() async {
    do {
      let valueTalks = try await getValueTalksUseCase.execute()
      self.valueTalks = valueTalks
    } catch {
      print(error)
      // API 수정되면 아래는 제거
      let valueTalks = [
        ValueTalkModel(
          id: 0,
          category: "연애관",
          title: "어떠한 사람과 연애가~~",
          placeholder: "연애에서 중요하게 생각하는 가치관",
          guides: [
            "함께 하고 싶은 데이트 스타일",
            "채식주의자 괜찮나요",
            "놀러가고 싶으세요?"
          ],
          answer: nil
        ),
        ValueTalkModel(
          id: 1,
          category: "꿈과 목표",
          title: "인생의 목표는 무엇?",
          placeholder: "단순한 목표 말구용",
          guides: [
            "함께 하고 싶은 데이트 스타일",
            "채식주의자 괜찮나요",
            "놀러가고 싶으세요?"
          ],
          answer: nil
        ),
      ]
      self.valueTalks = valueTalks
      
      cardViewModels = valueTalks.enumerated().map { index, talk in
        ValueTalkCardViewModel(model: talk, index: index)
      }
    }
  }
}
