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
import Router
import UseCases
import UIKit

@Observable
final class SplashViewModel {
  enum Action {
    case onAppear
    case openAppStore
  }
  
  var showNeedsForceUpdateAlert: Bool = false
  private(set) var destination: Route?
  
  private let getServerStatusUseCase: GetServerStatusUseCase
  private let socialLoginUseCase: SocialLoginUseCase
  
  init(
    getServerStatusUseCase: GetServerStatusUseCase,
    socialLoginUseCase: SocialLoginUseCase
  ) {
    self.getServerStatusUseCase = getServerStatusUseCase
    self.socialLoginUseCase = socialLoginUseCase
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
    /// - 본 적 있으면 로그인 요청 수행
    /// 3. OAuth 로그인
    /// - 로그인 후 role에 따라 화면 분기 처리
    /// - NONE: 소셜 로그인 완료, SMS 인증 전 > SMS 인증 화면으로
    /// - REGISTER: SMS 인증 완료 > 프로필 등록 화면으로
    /// - PENDING: 프로필 등록 완료, 프로필 심사중 > 매칭 메인 - 심사중
    /// - USER: 프로필 심사 완료 > 매칭 메인
    
    print("onAppear called")
    
    // 온보딩 여부 확인
    guard PCUserDefaultsService.shared.getDidSeeOnboarding() else {
      destination = .onboarding
      return
    }
    
    // 로그인 여부 확인 ( AccessToken 유무 확인 )
    guard let accessToken = PCKeychainManager.shared.read(.accessToken) else {
      print("AccessToken이 없어서 로그인 화면으로 이동")
      destination = .login
      return
    }
    print("AccessToken: \(accessToken)")
    
    // role에 따라 화면 분기 처리
    guard let role = PCKeychainManager.shared.read(.role) else {
      print("Role이 nil이어서 로그인 화면으로 이동")
      destination = .login
      return
    }
    print(role)
    
    switch role {
    case "NONE":
      print("---NONE---")
      destination = .verifyContact
    case "REGISTER":
      print("---REGISTER---")
      destination = .termsAgreement
    case "PENDING":
      print("---PENDING---")
      destination = .matchMain
    case "USER":
      print("---USER---")
      destination = .matchMain
    default:
      print("---\(role)---")
      destination = .login
    }
    
    
    Task {
      do {
        try await PCFirebase.shared.fetchRemoteConfigValues()
        showNeedsForceUpdateAlert = needsForceUpdate()
        let didSeeOnboarding = PCUserDefaultsService.shared.getDidSeeOnboarding()
        if didSeeOnboarding {
          // TODO: - SDK에 로그인 요청
          // TODO: - 서버에 로그인 요청
        }
      }  catch let error as PCFirebaseError {
        print("RemoteConfig fetch failed:", error.errorDescription)
      } catch {
        print(error)
      }
    }
  }
  
  private func needsForceUpdate() -> Bool {
    let currentVersion = AppVersion.appVersion()
    let minimumVersion = PCFirebase.shared.minimumVersion()
    let needsForceUpdate = PCFirebase.shared.needsForceUpdate()
    
    print("currentVersion: \(currentVersion)")
    print("minimumVersion: \(minimumVersion)")
    print("needsForceUpdate: \(needsForceUpdate)")
    return needsForceUpdate && currentVersion.compare(minimumVersion, options: .numeric) == .orderedAscending
  }
  
  private func openAppStore() {
    let appId = "6740155700" 
    let appStoreUrl = "itms-apps://itunes.apple.com/app/apple-store/\(appId)"
    guard let url = URL(string: appStoreUrl) else { return }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    }
  }
}
