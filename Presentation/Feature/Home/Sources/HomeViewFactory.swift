//
//  HomeViewFactory.swift
//  Home
//
//  Created by summercat on 1/30/25.
//

import SwiftUI
import UseCases

public struct HomeViewFactory {
  @ViewBuilder
  public static func createHomeView(
    // profile
    getProfileUseCase: GetProfileBasicUseCase,
    // matchMain
    getUserInfoUseCase: GetUserInfoUseCase,
    acceptMatchUseCase: AcceptMatchUseCase,
    getMatchesInfoUseCase: GetMatchesInfoUseCase,
    getMatchContactsUseCase: GetMatchContactsUseCase,
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
  ) -> some View {
    HomeView(
      // profile
      getProfileUseCase: getProfileUseCase,
      // matchMain
      getUserInfoUseCase: getUserInfoUseCase,
      acceptMatchUseCase: acceptMatchUseCase,
      getMatchesInfoUseCase: getMatchesInfoUseCase,
      getMatchContactsUseCase: getMatchContactsUseCase,
      getUserRejectUseCase: getUserRejectUseCase,
      patchMatchesCheckPieceUseCase: patchMatchesCheckPieceUseCase,
      // settings
      fetchTermsUseCase: fetchTermsUseCase,
      notificationPermissionUseCase: notificationPermissionUseCase,
      contactsPermissionUseCase: contactsPermissionUseCase,
      fetchContactsUseCase: fetchContactsUseCase,
      blockContactsUseCase: blockContactsUseCase,
      getContactsSyncTimeUseCase: getContactsSyncTimeUseCase,
      patchLogoutUseCase: patchLogoutUseCase
    )
  }
}
