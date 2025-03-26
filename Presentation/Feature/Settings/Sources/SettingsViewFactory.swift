//
//  SettingsViewFactory.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import UseCases

public struct SettingsViewFactory {
  public static func createSettingsView(
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    checkContactsPermissionUseCase: CheckContactsPermissionUseCase,
    requestContactsPermissionUseCase: RequestContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase,
    patchLogoutUseCase: PatchLogoutUseCase
  ) -> some View {
    SettingsView(
      fetchTermsUseCase: fetchTermsUseCase,
      notificationPermissionUseCase: notificationPermissionUseCase,
      checkContactsPermissionUseCase: checkContactsPermissionUseCase,
      requestContactsPermissionUseCase: requestContactsPermissionUseCase,
      fetchContactsUseCase: fetchContactsUseCase,
      blockContactsUseCase: blockContactsUseCase,
      getContactsSyncTimeUseCase: getContactsSyncTimeUseCase,
      patchLogoutUseCase: patchLogoutUseCase
    )
  }
  
  public static func createSettingsWebView(title: String, uri: String) -> some View {
    SettingsWebView(title: title, uri: uri)
  }
}
