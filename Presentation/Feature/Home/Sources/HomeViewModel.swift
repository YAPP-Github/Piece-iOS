//
// HomeViewModel.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import Observation
import SwiftUI
import UseCases

@Observable
final class HomeViewModel {
  enum Action { }
  
  init(
    getProfileUseCase: GetProfileUseCase,
    fetchTermsUseCase: FetchTermsUseCase
  ) {
    self.getProfileUseCase = getProfileUseCase
    self.fetchTermsUseCase = fetchTermsUseCase
  }
  
  let tabbarViewModel = TabBarViewModel()
  let getProfileUseCase: GetProfileUseCase
  let fetchTermsUseCase: FetchTermsUseCase
}
