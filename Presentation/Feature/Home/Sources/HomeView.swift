//
// HomeView.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import DesignSystem
import MatchingMain
import Profile
import Router
import Settings
import SwiftUI
import UseCases

struct HomeView: View {
  @State private var viewModel: HomeViewModel
  
  init(
    getProfileUseCase: GetProfileBasicUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        getProfileUseCase: getProfileUseCase,
        fetchTermsUseCase: fetchTermsUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase,
        fetchContactsUseCase: fetchContactsUseCase,
        blockContactsUseCase: blockContactsUseCase,
        getContactsSyncTimeUseCase: getContactsSyncTimeUseCase
      )
    )
  }

  var body: some View {
    ZStack {
      content
      TabBarView(viewModel: viewModel.tabbarViewModel)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  @ViewBuilder
  private var content: some View {
    switch viewModel.tabbarViewModel.selectedTab {
    case .profile:
      ProfileViewFactory.createProfileView(
        getProfileUseCase: viewModel.getProfileUseCase
      )
    case .home:
      // TODO: - MatchingMainView
      Rectangle()
        .fill(Color.red)
    case .settings:
      SettingsViewFactory.createSettingsView(
        fetchTermsUseCase: viewModel.fetchTermsUseCase,
        notificationPermissionUseCase: viewModel.notificationPermissionUseCase,
        contactsPermissionUseCase: viewModel.contactsPermissionUseCase,
        fetchContactsUseCase: viewModel.fetchContactsUseCase,
        blockContactsUseCase: viewModel.blockContactsUseCase,
        getContactsSyncTimeUseCase: viewModel.getContactsSyncTimeUseCase
      )
    }
  }
}
