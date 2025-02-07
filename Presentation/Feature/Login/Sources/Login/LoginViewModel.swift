//
//  LoginViewModel.swift
//  Login
//
//  Created by eunseou on 1/10/25.
//

import SwiftUI
import Observation
import KakaoSDKUser

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
  
  
  private func tapKakaoLoginButton() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          print("loginWithKakaoTalk() success.")
          
          // 성공 시 동작 구현
          _ = oauthToken
        }
      }
    }
  }
}
