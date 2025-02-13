//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import EditValuePick
import MatchingDetail
import Settings
import SignUp
import Home
import SignUp
import PCNetwork
import Repository
import Router
import SwiftUI
import UseCases

public struct Coordinator {
  public init() { }
  
  // MARK: - Repositories
  private let repositoryFactory = RepositoryFactory(networkService: NetworkService())
  
  // MARK: - UseCases
  private let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase()
  
  @ViewBuilder
  public func view(for route: Route) -> some View {
    switch route {
    case .home:
      let profileRepository = repositoryFactory.createProfileRepository()
      let termsRepository = repositoryFactory.createTermsRepository()
      let getProfileUseCase = UseCaseFactory.createGetProfileUseCase(repository: profileRepository)
      let fetchTermsUseCase = UseCaseFactory.createFetchTermsUseCase(repository: termsRepository)
      let notificationPermissionUseCase = UseCaseFactory.createNotificationPermissionUseCase()
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      HomeViewFactory.createHomeView(
        getProfileUseCase: getProfileUseCase,
        fetchTermsUseCase: fetchTermsUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase
      )
      
      // MARK: - 설정
    case let .settingsWebView(title, uri):
      SettingsViewFactory.createSettingsWebView(title: title, uri: uri)
      
      // MARK: - 매칭 상세
      
    case .matchProfileBasic:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchProfileBasicUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchProfileBasicView(
        getMatchProfileBasicUseCase: getMatchProfileBasicUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValueTalk:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchValueTalkUseCase = UseCaseFactory.createGetMatchValueTalkUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchValueTalkView(
        getMatchValueTalkUseCase: getMatchValueTalkUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValuePick:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchValuePickUseCase = UseCaseFactory.createGetMatchValuePickUseCase(repository: matchesRepository)
      let acceptMatchUseCase = UseCaseFactory.createAcceptMatchUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchValuePickView(
        getMatchValuePickUseCase: getMatchValuePickUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase,
        acceptMatchUseCase: acceptMatchUseCase
      )
      
      // MARK: - SignUp
    case .termsAgreement:
      let termsRepository = repositoryFactory.createTermsRepository()
      let fetchTermsUseCase = UseCaseFactory.createFetchTermsUseCase(repository: termsRepository)
      SignUpViewFactory.createTermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
      
    case .AvoidContactsGuide:
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      SignUpViewFactory.createAvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)
      
    case .signUp:
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      SignUpViewFactory.createAvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)
      
    case .createProfile:
      let profileRepository = repositoryFactory.createProfileRepository()
      let checkNicknameRepositoty = repositoryFactory.createCheckNicknameRepository()
      let uploadProfileImageRepository = repositoryFactory.createUploadProfileImageRepository()
      let valueTalksRepository = repositoryFactory.createValueTalksRepository()
      let valuePicksRepository = repositoryFactory.createValuePicksRepository()
      let checkNicknameUseCase = UseCaseFactory.createCheckNicknameUseCase(repository: checkNicknameRepositoty)
      let uploadProfileImageUseCase = UseCaseFactory.createUploadProfileImageUseCase(repository: uploadProfileImageRepository)
      let createProfileUseCase = UseCaseFactory.createProfileUseCase(repository: profileRepository)
      let getValueTalksUseCase = UseCaseFactory.createGetValueTalksUseCase(repository: valueTalksRepository)
      let getValuePicksUseCase = UseCaseFactory.createGetValuePicksUseCase(repository: valuePicksRepository)
      SignUpViewFactory.createProfileContainerView(
        checkNicknameUseCase: checkNicknameUseCase,
        uploadProfileImageUseCase: uploadProfileImageUseCase,
        getValueTalksUseCase: getValueTalksUseCase,
        getValuePicksUseCase: getValuePicksUseCase,
        createProfileUseCase: createProfileUseCase
      )
      
      // MARK: - Profile
    case .editValuePick:
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileValuePicksUseCase = UseCaseFactory.createGetProfileValuePicksUseCase(repository: profileRepository)
      let updateProfileValuePicksUseCase = UseCaseFactory.createUpdateProfileValuePicksUseCase(repository: profileRepository)
      EditValuePickViewFactory.createEditValuePickViewFactory(
        getProfileValuePicksUseCase: getProfileValuePicksUseCase,
        updateProfileValuePicksUseCase: updateProfileValuePicksUseCase
      )
    }
  }
}
