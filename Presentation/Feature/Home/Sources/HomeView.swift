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
    getUserInfoUseCase: GetUserInfoUseCase,
    acceptMatchUseCase: AcceptMatchUseCase,
    getMatchesInfoUseCase: GetMatchesInfoUseCase,
    getMatchContactsUseCase: GetMatchContactsUseCase,
    getUserRejectUseCase: GetUserRejectUseCase,
    patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase,
    fetchTermsUseCase: FetchTermsUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase,
    getContactsSyncTimeUseCase: GetContactsSyncTimeUseCase,
    patchLogoutUseCase: PatchLogoutUseCase
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        getProfileUseCase: getProfileUseCase,
        getUserInfoUseCase: getUserInfoUseCase,
        acceptMatchUseCase: acceptMatchUseCase,
        getMatchesInfoUseCase: getMatchesInfoUseCase,
        getMatchContactsUseCase: getMatchContactsUseCase,
        getUserRejectUseCase: getUserRejectUseCase,
        patchMatchesCheckPieceUseCase: patchMatchesCheckPieceUseCase,
        fetchTermsUseCase: fetchTermsUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase,
        fetchContactsUseCase: fetchContactsUseCase,
        blockContactsUseCase: blockContactsUseCase,
        getContactsSyncTimeUseCase: getContactsSyncTimeUseCase,
        patchLogoutUseCase: patchLogoutUseCase
      )
    )
  }

  var body: some View {
    ZStack {
      content
      TabBarView(viewModel: viewModel.tabbarViewModel)
    }
    .toolbar(.hidden)
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
      MatchMainViewFactory.createMatchMainView(
        getUserInfoUseCase: viewModel.getUserInfoUseCase,
        acceptMatchUseCase: viewModel.acceptMatchUseCase,
        getMatchesInfoUseCase: viewModel.getMatchesInfoUseCase,
        getMatchContactsUseCase: viewModel.getMatchContactsUseCase,
        getUserRejectUseCase: viewModel.getUserRejectUseCase,
        patchMatchesCheckPieceUseCase: viewModel.patchMatchesCheckPieceUseCase
      )
    case .settings:
      SettingsViewFactory.createSettingsView(
        fetchTermsUseCase: viewModel.fetchTermsUseCase,
        notificationPermissionUseCase: viewModel.notificationPermissionUseCase,
        contactsPermissionUseCase: viewModel.contactsPermissionUseCase,
        fetchContactsUseCase: viewModel.fetchContactsUseCase,
        blockContactsUseCase: viewModel.blockContactsUseCase,
        getContactsSyncTimeUseCase: viewModel.getContactsSyncTimeUseCase,
        patchLogoutUseCase: viewModel.patchLogoutUseCase
      )
    }
  }
}
