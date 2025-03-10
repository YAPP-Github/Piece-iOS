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
    // profile
    getProfileUseCase: GetProfileBasicUseCase,
    // matchmain
    getUserInfoUseCase: GetUserInfoUseCase,
    acceptMatchUseCase: AcceptMatchUseCase,
    getMatchesInfoUseCase: GetMatchesInfoUseCase,
    getUserRejectUseCase: GetUserRejectUseCase,
    patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase,
    // settings
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase,
    patchLogoutUseCase: PatchLogoutUseCase
  ) {
    // profile
    self.getProfileUseCase = getProfileUseCase
    // matchmain
    self.getUserInfoUseCase = getUserInfoUseCase
    self.acceptMatchUseCase = acceptMatchUseCase
    self.getMatchesInfoUseCase = getMatchesInfoUseCase
    self.getUserRejectUseCase = getUserRejectUseCase
    self.patchMatchesCheckPieceUseCase = patchMatchesCheckPieceUseCase
    // settings
    self.fetchTermsUseCase = fetchTermsUseCase
    self.notificationPermissionUseCase = notificationPermissionUseCase
    self.contactsPermissionUseCase = contactsPermissionUseCase
    self.fetchContactsUseCase = fetchContactsUseCase
    self.blockContactsUseCase = blockContactsUseCase
    self.getContactsSyncTimeUseCase = getContactsSyncTimeUseCase
    self.patchLogoutUseCase = patchLogoutUseCase
  }
  
  let tabbarViewModel = TabBarViewModel()
  // profile
  let getProfileUseCase: GetProfileBasicUseCase
  // matchmain
  let getUserInfoUseCase: GetUserInfoUseCase
  let acceptMatchUseCase: AcceptMatchUseCase
  let getMatchesInfoUseCase: GetMatchesInfoUseCase
  let getUserRejectUseCase: GetUserRejectUseCase
  let patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase
  // settings
  let fetchTermsUseCase: FetchTermsUseCase
  let notificationPermissionUseCase: NotificationPermissionUseCase
  let contactsPermissionUseCase: ContactsPermissionUseCase
  let fetchContactsUseCase: FetchContactsUseCase
  let blockContactsUseCase: BlockContactsUseCase
  let getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
  let patchLogoutUseCase: PatchLogoutUseCase
}
