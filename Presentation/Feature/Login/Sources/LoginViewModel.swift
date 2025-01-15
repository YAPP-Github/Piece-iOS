//
//  LoginViewModel.swift
//  Login
//
//  Created by eunseou on 1/10/25.
//

import SwiftUI
import Observation

@Observable
final class LoginViewModel {
  enum Action {
    case tapAppleLoginButton
    case tapKakaoLoginButton
    case tapGoogleLoginButton
  }
  
  func handleAction(_ action: Action) {
    switch action {
    default: return
    }
  }
}
