//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import MatchingDetail
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
  private let getMatchProfileBasicUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase()
  private let getMatchValueTalkUseCase = UseCaseFactory.createGetMatchValueTalkUseCase()
  private let getMatchValuePickUseCase = UseCaseFactory.createGetMatchValuePickUseCase()
  private let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase()
  
  @ViewBuilder
  public func view(for route: Route) -> some View {
    switch route {
    case .home:
      let getProfileUseCase = UseCaseFactory.createGetProfileUseCase()
      HomeViewFactory.createHomeView(getProfileUseCase: getProfileUseCase)
      
    case .matchProfileBasic:
      MatchDetailViewFactory.createMatchProfileBasicView(
        getMatchProfileBasicUseCase: getMatchProfileBasicUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValueTalk:
      MatchDetailViewFactory.createMatchValueTalkView(
        getMatchValueTalkUseCase: getMatchValueTalkUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValuePick:
      MatchDetailViewFactory.createMatchValuePickView(
        getMatchValuePickUseCase: getMatchValuePickUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
      
      // MARK: - SignUp
    case .termsAgreement:
      let termsRepository = repositoryFactory.createTermsRepository()
      let fetchTermsUseCase = UseCaseFactory.createFetchTermsUseCase(repository: termsRepository)
      SignUpViewFactory.createTermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
      
    case .AvoidContactsGuide:
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      SignUpViewFactory.createAvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)
    case .createProfile:
      let profileRepository = repositoryFactory.createProfileRepository()
      let valueTalksRepository = repositoryFactory.createValueTalksRepository()
      let createProfileUseCase = UseCaseFactory.createProfileUseCase(repository: profileRepository)
      let getValueTalksUseCase = UseCaseFactory.createGetValueTalksUseCase(repository: valueTalksRepository)
      
      SignUpViewFactory.createProfileContainerView(
        getValueTalksUseCase: getValueTalksUseCase,
        createProfileUseCase: createProfileUseCase
      )
    }
  }
}
