//
// SplashViewModel.swift
// Splash
//
// Created by summercat on 2025/02/14.
//

import LocalStorage
import Observation
import Router
import UseCases

@Observable
final class SplashViewModel {
  enum Action {
    case onAppear
  }
  
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
    }
  }
  
  private func onAppear() {
    /// 1.  API health check > 200 아니면 네트워크 연결이 불안정합니다 화면
    /// 2. 온보딩 여부 확인
    /// - 온보딩 본 적 없으면 온보딩 화면으로
    /// - 본 적 있으면 로그인 요청 수행
    /// 3. OAuth 로그인
    /// - 로그인 후 role에 따라 화면 분기 처리
    /// - NONE: 소셜 로그인 완료, SMS 인증 전 > SMS 인증 화면으로
    /// - REGISTER: SMS 인증 완료 > 프로필 등록 화면으로
    /// - PENDING: 프로필 등록 완료, 프로필 심사중 > 매칭 메인 - 심사중
    /// - USER: 프로필 심사 완료 > 매칭 메인
    Task {
      do {
        // 서버에서 response를 string 타입으로만 내려줘서 현재 항상 decoding error 발생하여 일단 주석처리함..
//        let serverStatus = try await getServerStatusUseCase.execute()
        let didSeeOnboarding = PCUserDefaultsService.shared.getDidSeeOnboarding()
        if didSeeOnboarding {
          // TODO: - SDK에 로그인 요청
          // TODO: - 서버에 로그인 요청
        }
      } catch {
        // TODO: - serverStatus 200이 아닌 경우 네트워크 환경이 불안정합니다 화면으로 이동
        print(error)
      }
    }
  }
}
