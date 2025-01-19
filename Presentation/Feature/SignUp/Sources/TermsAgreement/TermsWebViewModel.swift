//
//  TermsWebViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Observation

@Observable
final class TermsWebViewModel {
  enum Action {
    case tapAgreementButton
    case tapBackButton
  }
  
  var term: TermModel
  private var dismissAction: (() -> Void)?
  
  init(term: TermModel) {
    self.term = term
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapBackButton:
      dismissAction?()
    case .tapAgreementButton:
      return
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
}
