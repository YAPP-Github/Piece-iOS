//
// SettingsViewModel.swift
// Settings
//
// Created by summercat on 2025/02/12.
//

import Entities
import Foundation
import LocalStorage
import PCFoundationExtension
import SwiftUI
import UseCases
import Router

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
    case confirmLogoutButton
    case withdrawButtonTapped
    case clearDestination
  }
  
  var sections = [SettingSection]()
  var showLogoutAlert: Bool = false
  var isMatchingNotificationOn = false
  var isPushNotificationEnabled = false
  var isBlockContactsEnabled: Bool = false
  var updatedDate: Date? = nil
  var termsItems = [SettingsTermsItem]()
  var version = ""
  var loginInformationImage: Image?
  var loginEmail = "example@kakao.com" // TODO: - 이거 어디서 받아옴?
  let inquiriesUri = "https://kd0n5.channel.io/home"
  let noticeUri = "https://brassy-client-c0a.notion.site/16a2f1c4b96680e79a0be5e5cea6ea8a"
  
  private let userDefaults = PCUserDefaultsService.shared
  private let fetchTermsUseCase: FetchTermsUseCase
  private let notificationPermissionUseCase: NotificationPermissionUseCase
  private let checkContactsPermissionUseCase: CheckContactsPermissionUseCase
  private let requestContactsPermissionUseCase: RequestContactsPermissionUseCase
  private let fetchContactsUseCase: FetchContactsUseCase
  private let blockContactsUseCase: BlockContactsUseCase
  private let getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
  private let patchLogoutUseCase: PatchLogoutUseCase
  private(set) var tappedTermItem: SettingsTermsItem?
  private(set) var destination: Route?
  
  init(
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    checkContactsPermissionUseCase: CheckContactsPermissionUseCase,
    requestContactsPermissionUseCase: RequestContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase,
    patchLogoutUseCase: PatchLogoutUseCase
  ) {
    self.fetchTermsUseCase = fetchTermsUseCase
    self.notificationPermissionUseCase = notificationPermissionUseCase
    self.checkContactsPermissionUseCase = checkContactsPermissionUseCase
    self.requestContactsPermissionUseCase = requestContactsPermissionUseCase
    self.fetchContactsUseCase = fetchContactsUseCase
    self.blockContactsUseCase = blockContactsUseCase
    self.getContactsSyncTimeUseCase = getContactsSyncTimeUseCase
    self.patchLogoutUseCase = patchLogoutUseCase
    addObserver()
  }
  
  deinit {
    removeObserver()
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      onAppear()
      sections = [
        .init(id: .notification),
        .init(id: .system),
        .init(id: .ask),
        .init(id: .information),
        .init(id: .etc),
      ]
      
    case let .matchingNotificationToggled(isEnabled):
      matchingNotificationToggled(isEnabled: isEnabled)
      
    case let .pushNotificationToggled(isEnabled):
      pushNotificationToggled(isEnabled: isEnabled)
      
    case let .blockContactsToggled(isEnabled):
      blockContactsToggled(isEnabled: isEnabled)
      
    case .synchronizeContactsButtonTapped:
      synchronizeContacts()
      
    case let .termsItemTapped(id):
      tappedTermItem = termsItems.first(where: { $0.id == id })
      
    case .logoutItemTapped:
      showLogoutAlert = true
      
    case .confirmLogoutButton:
      tapComfirmLogout()
      
      break
    case .withdrawButtonTapped:
      destination = .withdraw
      
    case .clearDestination:
      destination = nil
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
      await checkPushNoficationPermission()
      await checkContactsPermission()
    }
  }
  
  private func onAppear() {
    fetchAppVersion()
    Task {
      await fetchTerms()
      await checkPushNoficationPermission()
      await checkContactsPermission()
    }
  }
  
  private func fetchAppVersion() {
    version = AppVersion.appVersion()
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
  
  private func checkPushNoficationPermission() async {
    do {
      let isPushNotificationEnabled = try await notificationPermissionUseCase.execute()
      self.isPushNotificationEnabled = isPushNotificationEnabled
    } catch {
      print(error)
    }
  }
  
  private func checkContactsPermission() async {
    let contactsAuthorizationStatus = checkContactsPermissionUseCase.execute()
    var isBlockContactsEnabled = false
    switch contactsAuthorizationStatus {
    case .notDetermined, .restricted, .denied:
      isBlockContactsEnabled = false
    case .authorized, .limited:
      isBlockContactsEnabled = true
    @unknown default:
      isBlockContactsEnabled = false
    }
    self.isBlockContactsEnabled = isBlockContactsEnabled
  }
  
  private func matchingNotificationToggled(isEnabled: Bool) {
    isMatchingNotificationOn = isEnabled
  }
  
  private func pushNotificationToggled(isEnabled: Bool) {
    isPushNotificationEnabled = isEnabled
    
    // 푸시알림을 끈 경우 매칭 알림도 같이 Off 처리
    if !isEnabled {
      isMatchingNotificationOn = isEnabled
    }
  }
  
  private func blockContactsToggled(isEnabled: Bool) {
    if isEnabled {
      Task {
        do {
          let authorizationStatus = checkContactsPermissionUseCase.execute()
          switch authorizationStatus {
          case .notDetermined:
            isBlockContactsEnabled = try await requestContactsPermissionUseCase.execute()
          case .restricted, .denied:
            if let url = URL(string: UIApplication.openSettingsURLString) {
              await UIApplication.shared.open(url)
            }
          case .authorized, .limited:
            isBlockContactsEnabled = true
          @unknown default:
            isBlockContactsEnabled = try await requestContactsPermissionUseCase.execute()
          }
        } catch {
          print(error)
          self.isBlockContactsEnabled = false
        }
      }
    } else {
      isBlockContactsEnabled = false
    }
  }
  
  private func synchronizeContacts() {
    if isBlockContactsEnabled {
      Task {
        let userContacts = try await fetchContactsUseCase.execute()
        _ = try await blockContactsUseCase.execute(phoneNumbers: userContacts)
        let response = try await getContactsSyncTimeUseCase.execute()
        let updatedDate = response.syncTime
        self.updatedDate = updatedDate
      }
    }
  }
  
  private func tapComfirmLogout() {
    // logout api 호출
    Task {
      do {
        _ = try await patchLogoutUseCase.execute()
      } catch {
        print(error)
      }
    }
    showLogoutAlert = false
    
    PCKeychainManager.shared.deleteAll()
    PCUserDefaultsService.shared.initialize()
    // 로그아웃 시 splash로 이동
    destination = .splash
  }
}
