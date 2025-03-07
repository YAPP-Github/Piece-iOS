//
// HomeViewModel.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import LocalStorage
import Observation
import UseCases

@Observable
final class HomeViewModel {
  enum Action { }
  
  init(
    getProfileUseCase: GetProfileBasicUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
  ) {
    self.getProfileUseCase = getProfileUseCase
    self.fetchTermsUseCase = fetchTermsUseCase
    self.notificationPermissionUseCase = notificationPermissionUseCase
    self.contactsPermissionUseCase = contactsPermissionUseCase
    self.fetchContactsUseCase = fetchContactsUseCase
    self.blockContactsUseCase = blockContactsUseCase
    self.getContactsSyncTimeUseCase = getContactsSyncTimeUseCase
  }
  
  let tabbarViewModel = TabBarViewModel()
  let getProfileUseCase: GetProfileBasicUseCase
  let fetchTermsUseCase: FetchTermsUseCase
  let notificationPermissionUseCase: NotificationPermissionUseCase
  let contactsPermissionUseCase: ContactsPermissionUseCase
  let fetchContactsUseCase: FetchContactsUseCase
  let blockContactsUseCase: BlockContactsUseCase
  let getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
}
