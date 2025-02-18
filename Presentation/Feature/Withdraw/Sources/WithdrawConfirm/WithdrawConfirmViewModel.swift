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

@Observable
final class WithdrawConfirmViewModel {
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
      Task { await handleContirmWithdraw() }
    }
  }
  
  private func handleContirmWithdraw() async {
    //PCKeychainManager.shared.read(.)
  }
  
  private func revokeKakao() async throws {
    // 1. Kakao 계정 해제 ( 비동기 처리 )
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
      UserApi.shared.unlink { error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: ())
        }
      }
    }
    // 2. 서버에 탈퇴 요청
    do {
      _ = try await deleteUserAccountUseCase.execute(reason: withdrawReason)
    } catch {
      print(error.localizedDescription)
    }
    
    // 로컬 데이터 초기화
    initialize()
  }

  private func revokeAppleIDCredential() async throws {
    do {
      
      // TODO: - 애플 탈퇴 구현
      /// 새롭게 업데이트되는 API를 이용해 서버와 합 맞춰봐야함!
      // 서버에 탈퇴 요청
      _ = try await deleteUserAccountUseCase.execute(reason: withdrawReason)
      
    } catch {
      print(error.localizedDescription)
    }
    
    // 로컬 데이터 초기화
    initialize()
  }
  
  private func initialize() {
    PCKeychainManager.shared.deleteAll()
    
    PCUserDefaultsService.shared.initialize()
    
    destination = .splash
  }
}

