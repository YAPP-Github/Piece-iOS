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
import Entities

@MainActor
@Observable
final class TermsAgreementViewModel {
  enum Action {
    case toggleAll
    case toggleTerm(id: Int)
    case tapChevronButton(with: TermModel)
  }
  
  init(fetchTermsUseCase: FetchTermsUseCase) {
    self.fetchTermsUseCase = fetchTermsUseCase
    
    fetchTerms()
  }
  
  private(set) var terms: [TermModel] = []
  var isShowWebView: Bool = false
  var isAllChecked: Bool {
    terms.allSatisfy { $0.isChecked }
  }
  var nextButtonType: RoundedButton.ButtonType {
    isAllChecked ? .solid : .disabled
  }
  private let fetchTermsUseCase: FetchTermsUseCase
  weak var selectedTerm: TermModel?
  
  func handleAction(_ action: Action) {
    switch action {
    case .toggleAll:
      let shouldAgree = !isAllChecked
      terms.forEach {
        shouldAgree ? $0.agree() : $0.disAgree()
      }
    case .toggleTerm(let id):
      terms
        .first(where: { $0.id == id })?
        .toggleAgreement()
    case .tapChevronButton(let term):
      selectedTerm = term
      isShowWebView = true
    }
  }
  
  func fetchTerms() {
    Task {
      do {
        let termsList = try await fetchTermsUseCase.execute()
        terms = termsList.responses.map { term in
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
