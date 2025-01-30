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
    getProfileUseCase: GetProfileUseCase
  ) {
    self.getProfileUseCase = getProfileUseCase
  }
  
  let tabbarViewModel = TabBarViewModel()
  private(set) var getProfileUseCase: GetProfileUseCase
}
