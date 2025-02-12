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
  
  let onModelUpdate: (ValuePickModel) -> Void
  let isEditing: Bool
  var model: ValuePickModel
  
  init(
    model: ValuePickModel,
    isEditing: Bool,
    onModelUpdate: @escaping (ValuePickModel) -> Void
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
