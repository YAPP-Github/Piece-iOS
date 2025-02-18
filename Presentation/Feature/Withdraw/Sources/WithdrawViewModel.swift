//
// WithdrawViewModel.swift
// Withdraw
//
// Created by 김도형 on 2025/02/13.
//

import Foundation
import UseCases

@Observable
final class WithdrawViewModel {
  enum Action {
    case bindingWithdraw(WithdrawType?)
    case bindingEditorText(String?)
  }
  
  private(set) var currentWithdraw: WithdrawType?
  private(set) var editorText: String?
  var isValid: Bool {
    guard currentWithdraw != nil else { return false }
    guard currentWithdraw != .기타 else {
      return editorText?.count ?? 0 > 0
    }
    return true
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .bindingWithdraw(let withdraw):
      currentWithdraw = withdraw
    case .bindingEditorText(let text):
      guard (text?.count ?? 0) <= 100 else { return }
      editorText = text
    }
  }
}
