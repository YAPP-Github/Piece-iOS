//
// BlockUserViewModel.swift
// BlockUser
//
// Created by summercat on 2025/02/12.
//

import Foundation

@Observable
final class BlockUserViewModel {
  enum Action {
    case didTapBottomButton
  }
  
  init() { }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapBottomButton:
      return
    }
  }
}
