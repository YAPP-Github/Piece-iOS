//
//  WithdrawConfirmViewModel.swift
//  Withdraw
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import UseCases
import Router
import LocalStorage
import KakaoSDKUser
import AuthenticationServices

@Observable
final class WithdrawConfirmViewModel: NSObject {
  enum Action {
    case confirmWithdraw
  }
  
  init(deleteUserAccountUseCase: DeleteUserAccountUseCase) {
    self.deleteUserAccountUseCase = deleteUserAccountUseCase
  }
  
  private(set) var destination: Route?
  private(set) var withdrawReason: String = ""
  private let deleteUserAccountUseCase: DeleteUserAccountUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case .confirmWithdraw:
      Task { await handleConfirmWithdraw() }
    }
  }
  
  private func handleConfirmWithdraw() async {
    let socialLoginType = PCUserDefaultsService.shared.getSocialLoginType()
    switch socialLoginType {
    case "apple":
      await handleWithdrawalProcess(revokeMethod: revokeAppleIDCredential)
    case "kakao":
      await handleWithdrawalProcess(revokeMethod: revokeKakao)
    default:
      print("Unsupported login type: \(socialLoginType)")
    }
  }
  
  private func handleWithdrawalProcess(revokeMethod: @escaping () async throws -> Void) async {
    do {
      try await revokeMethod()
      _ = try await deleteUserAccountUseCase.execute(reason: withdrawReason)
      initialize()
    } catch {
      print("Withdrawal failed: \(error.localizedDescription)")
    }
  }
  
  private func revokeKakao() async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
      UserApi.shared.unlink { error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: ())
        }
      }
    }
  }
  
  private func revokeAppleIDCredential() async {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  private func initialize() {
    PCKeychainManager.shared.deleteAll()
    
    PCUserDefaultsService.shared.initialize()
    
    destination = .splash
  }
}

extension WithdrawConfirmViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow } ?? UIWindow()
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
          let authorizationCodeData = appleIDCredential.authorizationCode,
          let authorizationCode = String(data: authorizationCodeData, encoding: .utf8) else {
      print("Apple ID Token is missing")
      return
    }
    
    print("🍎 authorizationCode : \(authorizationCode)")
    PCKeychainManager.shared.save(.appleAuthCode, value: authorizationCode)
  }
}
