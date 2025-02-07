//
//  TermsOfServiceViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/15/25.
//

import SwiftUI
import Observation
import DesignSystem
import UseCases

@Observable
final class TermsAgreementViewModel {
  enum Action {
    case toggleAll
    case toggleTerm(id: Int)
    case tapChevronButton(with: TermModel)
    case tapNextButton
    case tapBackButton
  }
  
  init(fetchTermsUseCase: FetchTermsUseCase) {
    self.fetchTermsUseCase = fetchTermsUseCase
  }
  
  
  var terms: [TermModel] = []

  var isAllChecked: Bool {
    terms.allSatisfy { $0.isChecked }
  }
  var nextButtonType: RoundedButton.ButtonType {
    isAllChecked ? .solid : .disabled
  }
  private let fetchTermsUseCase: FetchTermsUseCase
  
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
    default:
      return
    }
  }
  
  func fetchTerms() {
    Task {
      do {
        let termsList = try await fetchTermsUseCase.execute()
        terms = termsList.data.responses.map { term in
          TermModel(
            id: term.termId,
            title: term.title,
            url: term.content,
            required: term.required,
            isChecked: false
          )
        }
      } catch {
        print("❌ Error fetching terms: \(error.localizedDescription)")
      }
    }
  }
}
