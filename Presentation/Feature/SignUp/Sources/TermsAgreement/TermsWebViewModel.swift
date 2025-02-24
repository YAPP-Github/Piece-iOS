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
  }
  
  var term: TermModel?
  let title: String
  let url: String
  
  init(title: String, url: String) {
    self.title = title
    self.url = url
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAgreementButton:
      term?.isChecked = true
    }
  }
}
