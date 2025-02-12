//
// SettingsViewModel.swift
// Settings
//
// Created by summercat on 2025/02/12.
//

import Foundation
import SwiftUI
import UseCases

@Observable
final class SettingsViewModel {
  enum Action {
    case onAppear
    case synchronizeContactsButtonTapped
    case termsItemTapped(id: Int)
    case logoutItemTapped
    case withdrawButtonTapped
  }
  
  var sections = [SettingSection]()
  var isMatchingNotificationOn = false
  var isPushNotificationOn = false
  var isBlockingFriends = false
  var date = Date()
  var termsItems = [SettingsTermsItem]()
  var version = "버전 정보 v1.0" // TODO: - 버전 정보 받아오기
  var loginInformationImage: Image?
  var loginEmail = "example@kakao.com" // TODO: - 이거 어디서 받아옴?
  let inquiriesUri = "https://kd0n5.channel.io/home"
  let noticeUri = "https://brassy-client-c0a.notion.site/16a2f1c4b96680e79a0be5e5cea6ea8a"
  
  private let fetchTermsUseCase: FetchTermsUseCase
  private(set) var tappedTermItem: SettingsTermsItem?
  
  init(fetchTermsUseCase: FetchTermsUseCase) {
    self.fetchTermsUseCase = fetchTermsUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      sections = [
        .init(id: .loginInformation),
        .init(id: .notification),
        .init(id: .system),
        .init(id: .ask),
        .init(id: .information),
        .init(id: .etc),
      ]
      Task {
        await fetchTerms()
      }
      
    case .synchronizeContactsButtonTapped:
      // TODO: 연락처 동기화
      break
      
    case let .termsItemTapped(id):
      tappedTermItem = termsItems.first(where: { $0.id == id })

    case .logoutItemTapped:
      // TODO: 로그아웃
      break
    case .withdrawButtonTapped:
      // TODO: 탈퇴하기
      break
    }
  }
  
  private func fetchTerms() async {
    do {
      let terms = try await fetchTermsUseCase.execute()
      withAnimation {
        termsItems = terms.responses.map {
          SettingsTermsItem(id: $0.termId, title: $0.title, content: $0.content)
        }
      }
    } catch {
      
    }
  }
}
