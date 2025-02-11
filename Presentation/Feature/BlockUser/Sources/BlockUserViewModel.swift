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
    case didTapBlockUserAlertBackButton
    case didTapBlockUserAlertBlockUserButton
  }
  
  init() { }
  
  var isBlockUserAlertPresented: Bool = false
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapBottomButton:
      isBlockUserAlertPresented = true
      
    case .didTapBlockUserAlertBackButton:
      isBlockUserAlertPresented = false
      
    case .didTapBlockUserAlertBlockUserButton:
      isBlockUserAlertPresented = false
      // TODO: - API 요청
    }
  }
}
