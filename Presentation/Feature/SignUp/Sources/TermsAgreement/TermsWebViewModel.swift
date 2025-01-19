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
  
  init(term: TermModel) {
    self.term = term
  }
  
  func handleAction(_ action: Action) {
    switch action {
    default: return
    }
  }
}
