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

@MainActor
@Observable
final class HomeViewModel {
  enum Tab {
    case profile
    case home
    case settings
  }
  
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
    getSettingsInfoUseCase: GetSettingsInfoUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    checkNotificationPermissionUseCase: CheckNotificationPermissionUseCase,
    requestNotificationPermissionUseCase: RequestNotificationPermissionUseCase,
    changeNotificationRegisterStatusUseCase: ChangeNotificationRegisterStatusUseCase,
    checkContactsPermissionUseCase: CheckContactsPermissionUseCase,
    requestContactsPermissionUseCase: RequestContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase,
    putSettingsNotificationUseCase: PutSettingsNotificationUseCase,
    putSettingsMatchNotificationUseCase: PutSettingsMatchNotificationUseCase,
    putSettingsBlockAcquaintanceUseCase: PutSettingsBlockAcquaintanceUseCase,
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
    self.getSettingsInfoUseCase = getSettingsInfoUseCase
    self.fetchTermsUseCase = fetchTermsUseCase
    self.checkNotificationPermissionUseCase = checkNotificationPermissionUseCase
    self.requestNotificationPermissionUseCase = requestNotificationPermissionUseCase
    self.changeNotificationRegisterStatusUseCase = changeNotificationRegisterStatusUseCase
    self.checkContactsPermissionUseCase = checkContactsPermissionUseCase
    self.requestContactsPermissionUseCase = requestContactsPermissionUseCase
    self.fetchContactsUseCase = fetchContactsUseCase
    self.blockContactsUseCase = blockContactsUseCase
    self.getContactsSyncTimeUseCase = getContactsSyncTimeUseCase
    self.putSettingsNotificationUseCase = putSettingsNotificationUseCase
    self.putSettingsMatchNotificationUseCase = putSettingsMatchNotificationUseCase
    self.putSettingsBlockAcquaintanceUseCase = putSettingsBlockAcquaintanceUseCase
    self.patchLogoutUseCase = patchLogoutUseCase
  }
  
  // profile
  let getProfileUseCase: GetProfileBasicUseCase
  // matchmain
  let getUserInfoUseCase: GetUserInfoUseCase
  let acceptMatchUseCase: AcceptMatchUseCase
  let getMatchesInfoUseCase: GetMatchesInfoUseCase
  let getUserRejectUseCase: GetUserRejectUseCase
  let patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase
  // settings
  let getSettingsInfoUseCase: GetSettingsInfoUseCase
  let fetchTermsUseCase: FetchTermsUseCase
  let checkNotificationPermissionUseCase: CheckNotificationPermissionUseCase
  let requestNotificationPermissionUseCase: RequestNotificationPermissionUseCase
  let changeNotificationRegisterStatusUseCase: ChangeNotificationRegisterStatusUseCase
  let checkContactsPermissionUseCase: CheckContactsPermissionUseCase
  let requestContactsPermissionUseCase: RequestContactsPermissionUseCase
  let fetchContactsUseCase: FetchContactsUseCase
  let blockContactsUseCase: BlockContactsUseCase
  let getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
  let putSettingsNotificationUseCase: PutSettingsNotificationUseCase
  let putSettingsMatchNotificationUseCase: PutSettingsMatchNotificationUseCase
  let putSettingsBlockAcquaintanceUseCase: PutSettingsBlockAcquaintanceUseCase
  let patchLogoutUseCase: PatchLogoutUseCase
  
  // MARK: - State
  var selectedTab: Tab = .home
  var isProfileTabDisabled: Bool {
    PCUserDefaultsService.shared.getUserRole() != .USER
  }
}
