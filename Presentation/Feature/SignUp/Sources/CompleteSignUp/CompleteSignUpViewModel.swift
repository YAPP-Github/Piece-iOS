//
//  CompleteSignUpViewModel.swift
//  SignUp
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import Observation
import UseCases

@Observable
final class CompleteSignUpViewModel {
  enum Action {
    case tapNextButton
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapNextButton:
      // TODO: - 프로필 생성 플래그 심어야함!
      break
    }
  }
}
