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
    getProfileUseCase: GetProfileUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) -> some View {
    HomeView(
      getProfileUseCase: getProfileUseCase,
      fetchTermsUseCase: fetchTermsUseCase,
      notificationPermissionUseCase: notificationPermissionUseCase,
      contactsPermissionUseCase: contactsPermissionUseCase
    )
  }
}
