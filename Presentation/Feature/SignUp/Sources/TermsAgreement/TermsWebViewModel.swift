//
//  TermsWebViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Entities
import Observation

@Observable
final class TermsWebViewModel {
  enum Action {
    case tapAgreementButton
  }
  
  private(set) var term: TermModel
  
  var title: String { term.title }
  var url: String { term.url }
  
  init(term: TermModel) {
    self.term = term
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAgreementButton:
      term.agree()
    }
  }
}
