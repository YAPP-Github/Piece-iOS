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
  enum Action {
    case didTapBottomButton
    case updateValuePick(ProfileValuePickModel)
  }
  
  let profileCreator: ProfileCreator
  var showToast: Bool = false
  var valuePicks: [ProfileValuePickModel] = []
  
  let onUpdateValuePick: (ProfileValuePickModel) -> Void
  
  init(
    profileCreator: ProfileCreator,
    initialValuePicks: [ProfileValuePickModel],
    onUpdateValuePick: @escaping (ProfileValuePickModel) -> Void
  ) {
    self.profileCreator = profileCreator
    self.onUpdateValuePick = onUpdateValuePick
    
    // 초기 데이터는 항상 전달받은 initialValuePicks 사용
    self.valuePicks = initialValuePicks
    
    print("📌 ValuePickViewModel - 초기화")
    for (i, pick) in valuePicks.enumerated() {
      print("📌 valuePicks[\(i)]: ID=\(pick.id), selectedAnswer=\(String(describing: pick.selectedAnswer))")
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapBottomButton:
      print("=====================")
      print("📌 버튼 클릭 시 valuePicks 상태:")
        for (i, pick) in valuePicks.enumerated() {
          print("📌 valuePicks[\(i)]: ID=\(pick.id), Question=\(pick.question), selectedAnswer=\(String(describing: pick.selectedAnswer))")
        }
      let isValid = valuePicks.allSatisfy { $0.selectedAnswer != nil }
      print("📌 isValid: \(isValid)")
      if isValid {
        profileCreator.updateValuePicks(valuePicks)
        profileCreator.isValuePicksValid(true)
      } else {
        showToast = true
        profileCreator.isValuePicksValid(false)
      }
      
    case let .updateValuePick(model):
      print("📌 ValuePickViewModel - updateValuePick: \(model.id)")
        print("📌 받은 model의 selectedAnswer: \(String(describing: model.selectedAnswer))")
      if let index = valuePicks.firstIndex(where: { $0.id == model.id }) {
        print("📌 기존 valuePicks[\(index)].selectedAnswer: \(String(describing: valuePicks[index].selectedAnswer))")
        valuePicks[index] = model
        print("📌 변경 후 valuePicks[\(index)].selectedAnswer: \(String(describing: valuePicks[index].selectedAnswer))")
        
        onUpdateValuePick(model)
      }
    }
  }
}
