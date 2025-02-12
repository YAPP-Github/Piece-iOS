//
// SettingsViewModel.swift
// Settings
//
// Created by summercat on 2025/02/12.
//

import Foundation
import LocalStorage
import SwiftUI
import UseCases

@Observable
final class SettingsViewModel {
  enum Action {
    case onAppear
    case matchingNotificationToggled(Bool)
    case pushNotificationToggled(Bool)
    case blockContactsToggled(Bool)
    case synchronizeContactsButtonTapped
    case termsItemTapped(id: Int)
    case logoutItemTapped
    case withdrawButtonTapped
  }
  
  var sections = [SettingSection]()
  var isMatchingNotificationOn = false
  var isPushNotificationEnabled = false
  var isBlockContactsEnabled: Bool = false
  var updatedDate: Date? = nil
  var termsItems = [SettingsTermsItem]()
  var version = "버전 정보 v1.0" // TODO: - 버전 정보 받아오기
  var loginInformationImage: Image?
  var loginEmail = "example@kakao.com" // TODO: - 이거 어디서 받아옴?
  let inquiriesUri = "https://kd0n5.channel.io/home"
  let noticeUri = "https://brassy-client-c0a.notion.site/16a2f1c4b96680e79a0be5e5cea6ea8a"
  
  private let userDefaults = PCUserDefaultsService.shared
  private let fetchTermsUseCase: FetchTermsUseCase
  private let notificationPermissionUseCase: NotificationPermissionUseCase
  private let contactsPermissionUseCase: ContactsPermissionUseCase
  private(set) var tappedTermItem: SettingsTermsItem?
  
  init(
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) {
    self.fetchTermsUseCase = fetchTermsUseCase
    self.notificationPermissionUseCase = notificationPermissionUseCase
    self.contactsPermissionUseCase = contactsPermissionUseCase
    addObserver()
  }
  
  deinit {
    removeObserver()
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
        await checkPermissions()
      }
      
    case let .matchingNotificationToggled(isEnabled):
      matchingNotificationToggled(isEnabled: isEnabled)
      
    case let .pushNotificationToggled(isEnabled):
      pushNotificationToggled(isEnabled: isEnabled)
      
    case let .blockContactsToggled(isEnabled):
      blockContactsToggled(isEnabled: isEnabled)
      
    case .synchronizeContactsButtonTapped:
      // TODO: 연락처 동기화
      synchronizeContacts()
      
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
  
  private func addObserver() {
    // NotificationCenter를 통해 앱이 포그라운드로 돌아오는 이벤트를 감지
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(willEnterForeground),
      name: UIApplication.willEnterForegroundNotification,
      object: nil
    )
  }
  
  private func removeObserver() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc private func willEnterForeground() {
    Task {
      await checkPermissions()
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
      print(error)
    }
  }
  
  private func checkPermissions() async {
    do {
      let isPushNotificationEnabled = try await notificationPermissionUseCase.execute()
      let isBlockContactsEnabled = try await contactsPermissionUseCase.execute()
      self.isPushNotificationEnabled = isPushNotificationEnabled
      self.isBlockContactsEnabled = isBlockContactsEnabled
    } catch {
      print(error)
    }
  }
  
  private func matchingNotificationToggled(isEnabled: Bool) {
    isMatchingNotificationOn = isEnabled
    // TODO: - UserDefaults 저장
  }
  
  private func pushNotificationToggled(isEnabled: Bool) {
    isPushNotificationEnabled = isEnabled
    
    // 푸시알림을 끈 경우 매칭 알림도 같이 Off 처리
    if !isEnabled {
      isMatchingNotificationOn = isEnabled
    }
    // TODO: - UserDefaults 저장
  }
  
  private func blockContactsToggled(isEnabled: Bool) {
    if isEnabled {
      Task {
        do {
          let isBlockContactsEnabled = try await contactsPermissionUseCase.execute()
          self.isBlockContactsEnabled = isBlockContactsEnabled
        } catch {
          print(error)
          self.isBlockContactsEnabled = false
        }
      }
    } else {
      if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  private func synchronizeContacts() {
    if isBlockContactsEnabled {
      let updatedDate = Date()
      userDefaults.setBlockContactsLastUpdatedDate(updatedDate)
      self.updatedDate = updatedDate
    }
  }
}
