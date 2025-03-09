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
  
  init(
    deleteUserAccountUseCase: DeleteUserAccountUseCase,
    appleAuthServiceUseCase: AppleAuthServiceUseCase
  ) {
    self.deleteUserAccountUseCase = deleteUserAccountUseCase
    self.appleAuthServiceUseCase = appleAuthServiceUseCase
  }
  
  private(set) var destination: Route?
  private(set) var withdrawReason: String = ""
  private let deleteUserAccountUseCase: DeleteUserAccountUseCase
  private let appleAuthServiceUseCase: AppleAuthServiceUseCase
  
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
      await revokeAppleIDCredential()
    case "kakao":
      await revokeKakao()
    default:
      print("Unsupported login type: \(socialLoginType)")
    }
  }
  
  private func revokeKakao() async {
    UserApi.shared.unlink { error in
      if let error = error {
        print(error)
      }
    }
    do {
      _ = try await deleteUserAccountUseCase.execute(providerName: "kakao", oauthCredential: "", reason: withdrawReason)
      
      await MainActor.run {
        initialize()
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func revokeAppleIDCredential() async {
    print("🔍 Apple 탈퇴 진행")
    
    do {
      let appleIDProvider = try await appleAuthServiceUseCase.execute()
      print("✅ Apple authorization code : \(appleIDProvider.authorizationCode)")
      do {
        _ = try await deleteUserAccountUseCase.execute(
          providerName: "apple",
          oauthCredential: appleIDProvider.authorizationCode,
          reason: withdrawReason
        )
        print("✅ DeleteUserAccount success")
      } catch let error as NSError {
        if error.localizedDescription.contains("Status Code: 200") {
          print("✅ DeleteUserAccount 성공 (Status 200)")
        } else {
          throw error
        }
      }
      
      await MainActor.run {
        initialize()
      }
    } catch {
      print("\(error.localizedDescription)")
    }
  }
  
  private func initialize() {
    print("✅ Initialize started")
    PCKeychainManager.shared.deleteAll()
    print("✅ Keychain deleted")
    PCUserDefaultsService.shared.initialize()
    print("✅ UserDefaults initialized")
    destination = .splash
    print("✅ splash로 이동")
  }
}
