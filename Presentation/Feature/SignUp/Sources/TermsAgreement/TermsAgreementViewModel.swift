//
//  TermsOfServiceViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/15/25.
//

import SwiftUI
import Observation
import DesignSystem

@Observable
final class TermsAgreementViewModel {
  enum Action {
    case toggleAll
    case toggleTerm(id: Int)
    case tapChevronButton(with: TermModel)
    case tapNextButton
    case tapBackButton
  }
  
  init(
    terms: [TermModel],
    navigationPath: NavigationPath
  ) {
    self.terms = terms
    self.navigationPath = navigationPath
  }
  
  var terms: [TermModel]
  var navigationPath: NavigationPath
  var isAllChecked: Bool {
    terms.allSatisfy { $0.isChecked }
  }
  var nextButtonType: RoundedButton.ButtonType {
    isAllChecked ? .solid : .disabled
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .toggleAll:
      let newState = !isAllChecked
      terms.indices.forEach {
        terms[$0].isChecked = newState
      }
    case .toggleTerm(let id):
      if let index = terms.firstIndex(where: { $0.id == id }) {
        terms[index].isChecked.toggle()
      }
    case .tapChevronButton(let term):
      navigationPath.append(term)
    default:
      return
    }
  }
}
