//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import Withdraw
import EditValuePick
import EditValueTalk
import Login
import BlockUser
import MatchingDetail
import Home
import Onboarding
import PCNetwork
import Repository
import Router
import SignUp
import SwiftUI
import UseCases
import EditValuePick
import Splash
import Settings

public struct Coordinator {
  public init() { }
  
  // MARK: - Repositories
  private let repositoryFactory = RepositoryFactory(networkService: NetworkService.shared)
  
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
      
    case .onboarding:
      OnboardingViewFactory.createOnboardingView()
      
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
      let refuseMatchUseCase = UseCaseFactory.createRefuseMatchUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchValuePickView(
        getMatchValuePickUseCase: getMatchValuePickUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase,
        acceptMatchUseCase: acceptMatchUseCase,
        refuseMatchUseCase: refuseMatchUseCase
      )
      
    case let .blockUser(matchId, nickname):
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let blockUserUseCase = UseCaseFactory.createBlockUserUseCase(repository: matchesRepository)
      BlockUserViewFactory.createBlockUserView(
        matchId: matchId,
        nickname: nickname,
        blockUserUseCase: blockUserUseCase
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
    case .editValueTalk:
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileValueTalksUseCase = UseCaseFactory.createGetProfileValueTalksUseCase(repository: profileRepository)
      let updateProfileValueTalksUseCase = UseCaseFactory.createUpdateProfileValueTalksUseCase(repository: profileRepository)
      EditValueTalkViewFactory.createEditValueTalkViewFactory(
        getProfileValueTalksUseCase: getProfileValueTalksUseCase,
        updateProfileValueTalksUseCase: updateProfileValueTalksUseCase
      )
      
    case .editValuePick:
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileValuePicksUseCase = UseCaseFactory.createGetProfileValuePicksUseCase(repository: profileRepository)
      let updateProfileValuePicksUseCase = UseCaseFactory.createUpdateProfileValuePicksUseCase(repository: profileRepository)
      EditValuePickViewFactory.createEditValuePickViewFactory(
        getProfileValuePicksUseCase: getProfileValuePicksUseCase,
        updateProfileValuePicksUseCase: updateProfileValuePicksUseCase
      )
        
    case .withdraw:
        WithdrawViewFactory.createWithdrawView()
      
    case .withdrawConfirm:
        WithdrawViewFactory.createWithdrawConfirm()
      
    case .login:
      let loginRepository = repositoryFactory.createLoginRepository()
      let socialLoginUseCase = UseCaseFactory.createSocialLoginUseCase(repository: loginRepository)
      LoginViewFactory.createLoginView(socialLoginUseCase: socialLoginUseCase)
      
    case .splash:
      let commonRepository = repositoryFactory.createCommonRepository()
      let loginRepository = repositoryFactory.createLoginRepository()
      let getServerStatusUseCase = UseCaseFactory.createGetServerStatusUseCase(repository: commonRepository)
      let socialLoginUseCase = UseCaseFactory.createSocialLoginUseCase(repository: loginRepository)
      SplashViewFactory.createSplashView(
        getServerStatusUseCase: getServerStatusUseCase,
        socialLoginUseCase: socialLoginUseCase
      )

    }
  }
}
