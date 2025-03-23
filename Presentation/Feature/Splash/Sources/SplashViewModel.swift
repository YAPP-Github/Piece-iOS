//
// SplashViewModel.swift
// Splash
//
// Created by summercat on 2025/02/14.
//

import LocalStorage
import Observation
import PCFirebase
import PCFoundationExtension
import PCNetwork
import Router
import UseCases
import UIKit
import Entities

@MainActor
@Observable
final class SplashViewModel {
  enum Action {
    case onAppear
    case openAppStore
  }
  
  var showNeedsForceUpdateAlert: Bool = false
  private(set) var destination: Route?
  
  private let getUserInfoUseCase: GetUserInfoUseCase
  
  init(getUserInfoUseCase: GetUserInfoUseCase) {
    self.getUserInfoUseCase = getUserInfoUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      onAppear()
      
    case .openAppStore:
      openAppStore()
    }
  }
  
  private func onAppear() {
    /// 1.  강제 업데이트 필요 여부 확인
    /// 2. 온보딩 여부 확인
    /// - 온보딩 본 적 없으면 온보딩 화면으로
    /// - 본 적 있으면 토큰 확인
    /// 3. 인증 토큰 확인
    /// - accessToken이 유효하면 바로 사용
    /// - accessToken이 유효하지 않으면 refreshToken으로 갱신 시도 (Interceptor에서 처리)
    /// - 둘 다 없거나 갱신 실패시 로그인 화면으로 이동
    /// 4. 인증 성공 후 role에 따라 화면 분기 처리
    /// - NONE: 소셜 로그인 완료, SMS 인증 전 > SMS 인증 화면으로
    /// - REGISTER: SMS 인증 완료 > 프로필 등록 화면으로
    /// - PENDING: 프로필 등록 완료, 프로필 심사중 > 매칭 메인 - 심사중
    /// - USER: 프로필 심사 완료 > 매칭 메인
    
    print("Splash onAppear called")
    
    Task {
      do {
        try await checkForceUpdate()
        
        guard checkOnboarding() else { return }
        
        checkAccesstoken()
        try await setRoute()
      } catch let error as NetworkError {
        switch error {
        case .badRequest(let error):
          print("bad request error: \(error?.message ?? "")")
        case .unauthorized(let error):
          if error?.code == "INVALID_REFRESH_TOKEN" {
            destination = .login
          }
        case .forbidden:
          print("forbidden")
          destination = .login
        case .notFound:
          print("not found")
          destination = .login
        case .internalServerError:
          print("internal server error")
        case .statusCode(let int):
          print("status code: \(int)")
        case .missingStatusCode:
          print("missing status code")
        case .emptyResponse:
          print("empty response")
        case .encodingFailed:
          print("encoding failed")
        case .decodingFailed:
          print("decoding failed")
        case .noRefreshToken:
          destination = .login
        }
      } catch {
        handleError(error)
      }
    }
  }
  
  // MARK: - onAppear 시 로직
  
  private func checkForceUpdate() async throws {
    try await PCFirebase.shared.fetchRemoteConfigValues()
    let currentVersion = AppVersion.appVersion()
    let minimumVersion = PCFirebase.shared.minimumVersion()
    let needsForceUpdate = currentVersion.compare(minimumVersion, options: .numeric) == .orderedAscending
    
    print("currentVersion: \(currentVersion)")
    print("minimumVersion: \(minimumVersion)")
    print("needsForceUpdate: \(needsForceUpdate)")
    showNeedsForceUpdateAlert = needsForceUpdate
  }
  
  private func checkOnboarding() -> Bool {
    guard PCUserDefaultsService.shared.getDidSeeOnboarding() else {
      print("온보딩을 본 적 없어 온보딩 화면으로 이동")
      destination = .onboarding
      return false
    }
    return true
  }
  
  private func checkAccesstoken() {
    // 로그인 여부 확인 ( AccessToken 유무 확인 )
    guard let accessToken = PCKeychainManager.shared.read(.accessToken) else {
      print("AccessToken이 없어서 로그인 화면으로 이동")
      destination = .login
      return
    }
    print("SplashView AccessToken: \(accessToken)")
  }
  
  private func openAppStore() {
    let appId = "6740155700"
    let appStoreUrl = "itms-apps://itunes.apple.com/app/apple-store/\(appId)"
    guard let url = URL(string: appStoreUrl) else { return }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    }
  }
  
  private func setRoute() async throws {
    // 사용자 role에 따라 화면 분기 처리
    let userInfo = try await getUserInfoUseCase.execute()
    let userRole = userInfo.role
    PCUserDefaultsService.shared.setUserRole(userRole)
    
    switch userRole {
    case .NONE:
      print("---NONE---")
      destination = .verifyContact
    case .REGISTER:
      print("---REGISTER---")
      destination = .termsAgreement
    case .PENDING:
      print("---PENDING---")
      destination = .home
    case .USER:
      print("---USER---")
      destination = .home
    }
  }
  
  private func handleError(_ error: Error) {
    if let networkError = error as? NetworkError {
      handleNetworkError(networkError)
    } else {
      // 일반 에러 처리
      print("Unexpected error: \(error.localizedDescription)")
    }
  }
  
  private func handleNetworkError(_ error: NetworkError) {
    switch error {
    case .badRequest(let apiError):
      print("Bad request: \(apiError?.message ?? "Unknown error")")
      
    case .unauthorized(let apiError):
      if apiError?.code == "INVALID_REFRESH_TOKEN" {
        destination = .login
      } else {
        print("Unauthorized: \(apiError?.message ?? "Unknown error")")
      }
      
    case .forbidden:
      print("Forbidden: Access denied")
      
    case .notFound:
      print("Resource not found")
      
    case .internalServerError:
      print("Server error occurred")
      
    case .statusCode(let code):
      print("Unexpected status code: \(code)")
      
    case .missingStatusCode:
      print("Missing status code in response")
      
    case .emptyResponse:
      print("Empty response received")
      
    case .encodingFailed:
      print("Failed to encode request data")
      
    case .decodingFailed:
      print("Failed to decode response data")
      
    case .noRefreshToken:
      destination = .login
    }
  }
}
