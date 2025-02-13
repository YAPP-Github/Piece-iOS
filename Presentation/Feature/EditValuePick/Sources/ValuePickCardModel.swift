//
//  ValuePickCardModel.swift
//  EditValuePick
//
//  Created by summercat on 2/12/25.
//

import Entities
import Observation

@Observable
final class ValuePickCardViewModel {
  enum Action {
    case didTapAnswer(id: Int)
  }
  
  let onModelUpdate: (ProfileValuePickModel) -> Void
  let isEditing: Bool
  var model: ProfileValuePickModel
  
  init(
    model: ProfileValuePickModel,
    isEditing: Bool,
    onModelUpdate: @escaping (ProfileValuePickModel) -> Void
  ) {
    self.model = model
    self.isEditing = isEditing
    self.onModelUpdate = onModelUpdate
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapAnswer(let id):
      model.selectedAnswer = id
      onModelUpdate(model)
    }
  }
}
