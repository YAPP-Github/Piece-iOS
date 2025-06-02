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

@MainActor
@Observable
final class WithdrawConfirmViewModel: NSObject {
  enum Action {
    case confirmWithdraw
  }
  
  init(
    deleteUserAccountUseCase: DeleteUserAccountUseCase,
    appleAuthServiceUseCase: AppleAuthServiceUseCase,
    withdrawReason: String
  ) {
    self.deleteUserAccountUseCase = deleteUserAccountUseCase
    self.appleAuthServiceUseCase = appleAuthServiceUseCase
    self.withdrawReason = withdrawReason
  }
  
  private(set) var destination: Route?
  private var withdrawReason: String
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
    case "google":
      await revokeGoogle()
    default:
      print("Unsupported login type: \(socialLoginType)")
    }
  }
  
  private func revokeKakao() async {
    print("🔍 Kakao 탈퇴 진행")
    
    await withCheckedContinuation { continuation in
      UserApi.shared.unlink { error in
        if let error = error {
          print("❌ Kakao unlink error: \(error)")
        } else {
          print("✅ Kakao unlink success")
        }
        continuation.resume()
      }
    }
    
    do {
      do {
        _ = try await deleteUserAccountUseCase.execute(
          providerName: "kakao",
          oauthCredential: "",
          reason: withdrawReason
        )
        print("✅ DeleteUserAccount success")
      } catch let error as NSError {
        // 200 상태 코드인 경우 성공으로 처리
        if error.localizedDescription.contains("Status Code: 200") {
          print("✅ DeleteUserAccount 성공 (Status 200)")
        } else {
          throw error
        }
      }
      
      // 성공 시 initialize 호출
      await MainActor.run {
        initialize()
      }
    } catch {
      print("\(error.localizedDescription)")
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
  
  private func revokeGoogle() async {
    print("🔍 Google 탈퇴 진행")
    
    do {
      _ = try await deleteUserAccountUseCase.execute(
        providerName: "google",
        oauthCredential: "",
        reason: withdrawReason
      )
      print("✅ DeleteUserAccount success")
      
      await MainActor.run {
        initialize()
      }
    } catch let error as NSError {
      if error.localizedDescription.contains("Status Code: 200") {
        print("✅ DeleteUserAccount 성공 (Status 200)")
        await MainActor.run {
          initialize()
        }
      } else {
        print("\(error.localizedDescription)")
      }
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
