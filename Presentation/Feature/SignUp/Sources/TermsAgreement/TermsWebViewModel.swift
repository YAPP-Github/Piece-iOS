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
  var checkTerm: ((TermModel) -> Void)?
  private var dismissAction: (() -> Void)?
  
  init(
    term: TermModel,
    checkTerm: ((TermModel) -> Void)? = nil
  ) {
    self.term = term
    self.checkTerm = checkTerm
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapBackButton:
      dismissAction?()
    case .tapAgreementButton:
      term.isChecked = true
      checkTerm?(term)
      dismissAction?()
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
}
