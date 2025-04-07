//
//  LoginViewModel.swift
//  Login
//
//  Created by eunseou on 1/10/25.
//

import SwiftUI
import Observation
import KakaoSDKAuth
import KakaoSDKUser
//import GoogleSignIn
//import GoogleSignInSwift
import AuthenticationServices
import UseCases
import LocalStorage
import Router
import Entities

@MainActor
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
  private(set) var destination: Route?
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAppleLoginButton:
      Task {
        await handleAppleLoginButton()
      }
    case .tapKakaoLoginButton:
      Task {
        await handleKakaoLoginButton()
      }
    case .tapGoogleLoginButton: break
     // handleGoogleLoginButton()
    }
  }
  
  private func handleAppleLoginButton() async {
    // TODO: - Apple Login Action
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  private func handleKakaoLoginButton() async {
//    // TODO: - Kakao Login Action
    if UserApi.isKakaoTalkLoginAvailable() {
      // 카카오톡 앱이 설치된 경우
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        if let error = error {
          print("KakaoTalk login failed: \(error.localizedDescription)")
          self.loginWithKakaoAccount() // 앱 로그인이 실패하면 웹 로그인 시도
          return
        }
        self.handleKakaoLoginSuccess(oauthToken)
      }
    } else {
      // 카카오톡 앱이 없는 경우 바로 웹 로그인 진행
      loginWithKakaoAccount()
    }
  }
  
  private func loginWithKakaoAccount() {
    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
      if let error = error {
        print("Kakao Web login failed: \(error.localizedDescription)")
        return
      }
      self.handleKakaoLoginSuccess(oauthToken)
    }
  }
  
  private func handleKakaoLoginSuccess(_ oauthToken: OAuthToken?) {
    guard let token = oauthToken?.accessToken else { return }
    Task {
      do {
        let socialLoginResponse = try await socialLoginUseCase.execute(providerName: .kakao, token: token)
        print("Social login success: \(socialLoginResponse)")
        PCUserDefaultsService.shared.setSocialLoginType("kakao")
        setRoute(userRole: socialLoginResponse.role)
      } catch {
        print("Social login failed: \(error.localizedDescription)")
      }
    }
  }
  
  private func handleGoogleLoginButton() {
    // TODO: - Google Login Action
//    guard let rootViewController = UIApplication.shared.connectedScenes
//      .compactMap({ $0 as? UIWindowScene })
//      .flatMap({ $0.windows })
//      .first(where: { $0.isKeyWindow }) else {
//      print("❌ RootViewController를 찾을 수 없습니다.")
//      return
//    }
    
//    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
//      if let error = error {
//        print("Google Login failed: \(error.localizedDescription)")
//        return
//      }
//      
//      guard let result = signInResult else {
//        print("Google Login failed: signInResult is nil")
//        return
//      }
//      
//      // ID Token 가져오기
//      guard let idToken = result.user.idToken?.tokenString else {
//        print("Google ID Token is missing")
//        return
//      }
//      
//      print("🟢 Google ID Token: \(idToken)")
//      
//      Task {
//        do {
//          let socialLoginResponse = try await self.socialLoginUseCase.execute(providerName: .google, token: idToken)
//          print("Google Login Success: \(socialLoginResponse)")
//        } catch {
//          print("Google Login Error: \(error.localizedDescription)")
//        }
//      }
//    }
  }
}

extension LoginViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow } ?? UIWindow()
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
          let identityTokenData = appleIDCredential.identityToken,
          let identityToken = String(data: identityTokenData, encoding: .utf8),
          let authorizationCodeData = appleIDCredential.authorizationCode,
          let authorizationCode = String(data: authorizationCodeData, encoding: .utf8) else {
      print("Apple ID Token is missing")
      return
    }
    
    print("🍎 identityToken : \(identityToken)")
    print("🍎 authorizationCode : \(authorizationCode)")
    
    Task {
      do {
        let socialLoginResponse = try await socialLoginUseCase.execute(providerName: .apple, token: authorizationCode)
        print("Apple Login Success: \(socialLoginResponse)")
        PCUserDefaultsService.shared.setSocialLoginType("apple")
        setRoute(userRole: socialLoginResponse.role)
      } catch {
        print("Apple Login Error: \(error.localizedDescription)")
      }
    }
  }
  
  private func setRoute(userRole: UserRole) {
    switch userRole {
    case .NONE:
      destination = .verifyContact
    case .REGISTER:
      destination = .termsAgreement
    case .PENDING:
      destination = .home
    case .USER:
      destination = .home
    }
  }
}
