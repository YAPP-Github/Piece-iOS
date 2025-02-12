//
//  LoginViewModel.swift
//  Login
//
//  Created by eunseou on 1/10/25.
//

import SwiftUI
import Observation
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices
import UseCases
import LocalStorage

@Observable
final class LoginViewModel: NSObject {
  
  enum Action {
    case tapAppleLoginButton
    case tapKakaoLoginButton
    case tapGoogleLoginButton
  }
  
  init(socialLoginUseCase: SocialLoginUseCase) {
    self.socialLoginUseCase = socialLoginUseCase
  }
  
  private let socialLoginUseCase: SocialLoginUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAppleLoginButton:
      handleAppleLoginButton()
    case .tapKakaoLoginButton:
      handleKakaoLoginButton()
    case .tapGoogleLoginButton:
      handleGoogleLoginButton()
    }
  }
  
  private func handleAppleLoginButton() async {
    // TODO: - Apple Login Action
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
    
    let socialLoginResponse = try await socialLoginUseCase.execute(providerName: .apple, token: "")
  }
  
  private func handleKakaoLoginButton() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          print("loginWithKakaoTalk() success.")
          
          // 성공 시 동작 구현
          let accessToken = oauthToken?.accessToken
          let refreshToken = oauthToken?.refreshToken
          let idToken = oauthToken?.idToken
         
          let socialLoginResponse = try await socialLoginUseCase.execute(providerName: .kakao, token: idToken ?? "")
          
        }
      }
    }
    
    let socialLoginResponse = try await socialLoginUseCase.execute(providerName: .apple, token: "")
  }
  
  private func handleGoogleLoginButton() {
    // TODO: - Google Login Action
  }
}

extension LoginViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) async {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      
      let userIdentifier = appleIDCredential.user
      let fullName = appleIDCredential.fullName
      let email = appleIDCredential.email
      
     // KeychainManager.save(Keychain.accessToken, value: userIdentifier)
      
    case let passwordCredential as ASPasswordCredential:
      let username = passwordCredential.user
      let password = passwordCredential.password
      
      
    default:
      break
    }
  }
  
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return ASPresentationAnchor()
  }
}
