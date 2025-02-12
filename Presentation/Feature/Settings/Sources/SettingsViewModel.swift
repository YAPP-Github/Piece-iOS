//
// SettingsViewModel.swift
// Settings
//
// Created by summercat on 2025/02/12.
//

import Foundation
import SwiftUI
import UseCases

@Observable
final class SettingsViewModel {
  enum Action {
    case onAppear
    case withdrawButtonTapped
  }
  
  var termsItems = [SettingsTermsItem]()
  private let fetchTermsUseCase: FetchTermsUseCase
  
  init(fetchTermsUseCase: FetchTermsUseCase) {
    self.fetchTermsUseCase = fetchTermsUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      sections = [
        .init(id: .loginInformation),
        .init(id: .notification),
        .init(id: .system),
        .init(id: .ask),
        .init(id: .information),
        .init(id: .etc),
      ]
      Task {
        await fetchTerms()
      }
    case .withdrawButtonTapped:
      // TODO: 탈퇴하기
      break
    }
  }
  
  private func fetchTerms() async {
    do {
      let terms = try await fetchTermsUseCase.execute()
      withAnimation {
        termsItems = terms.responses.map {
          SettingsTermsItem(id: $0.termId, title: $0.title, content: $0.content)
        }
      }
    } catch {
      
    }
  }
}
