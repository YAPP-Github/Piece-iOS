//
// HomeViewModel.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import Observation
import SwiftUI
import UseCases

@Observable
final class HomeViewModel {
  enum Action { }
  
  init(
    getProfileUseCase: GetProfileUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) {
    self.getProfileUseCase = getProfileUseCase
    self.fetchTermsUseCase = fetchTermsUseCase
    self.notificationPermissionUseCase = notificationPermissionUseCase
    self.contactsPermissionUseCase = contactsPermissionUseCase
  }
  
  let tabbarViewModel = TabBarViewModel()
  let getProfileUseCase: GetProfileUseCase
  let fetchTermsUseCase: FetchTermsUseCase
  let notificationPermissionUseCase: NotificationPermissionUseCase
  let contactsPermissionUseCase: ContactsPermissionUseCase
}
