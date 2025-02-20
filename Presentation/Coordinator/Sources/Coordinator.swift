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
import MatchingMain
import Splash
import Settings
import ReportUser

public struct Coordinator {
  public init() { }
  
  // MARK: - Repositories
  private let repositoryFactory = RepositoryFactory(networkService: NetworkService.shared)
  
  // MARK: - UseCases
  
  @ViewBuilder
  public func view(for route: Route) -> some View {
    switch route {
      // MARK: - 로그인
    case .login:
      let socialLoginRepository = repositoryFactory.createLoginRepository()
      let socialLoginUseCase = UseCaseFactory.createSocialLoginUseCase(repository: socialLoginRepository)
      LoginViewFactory.createLoginView(socialLoginUseCase: socialLoginUseCase)
      
    case .verifyContact:
      let loginRepository = repositoryFactory.createLoginRepository()
      let sendSMSCodeUseCase = UseCaseFactory.createSendSMSCodeUseCase(repository: loginRepository)
      let verifySMSCodeUseCase = UseCaseFactory.createVerifySMSCodeUseCase(repository: loginRepository)
      LoginViewFactory.createVerifingContactView(
        sendSMSCodeUseCase: sendSMSCodeUseCase,
        verifySMSCodeUseCase: verifySMSCodeUseCase
      )
    case .home:
      let profileRepository = repositoryFactory.createProfileRepository()
      let termsRepository = repositoryFactory.createTermsRepository()
      let blockContactsRepository = repositoryFactory.createBlockContactsRepository()
      let settingsRepository = repositoryFactory.createSettingsRepository()
      let getProfileUseCase = UseCaseFactory.createGetProfileUseCase(repository: profileRepository)
      let fetchTermsUseCase = UseCaseFactory.createFetchTermsUseCase(repository: termsRepository)
      let notificationPermissionUseCase = UseCaseFactory.createNotificationPermissionUseCase()
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      let fetchContactsUseCase = UseCaseFactory.createFetchContactsUseCase()
      let blockContactsUseCase = UseCaseFactory.createBlockContactsUseCase(repository: blockContactsRepository)
      let getContactsSyncTimeUseCase = UseCaseFactory.createGetContactsSyncTimeUseCase(repository: settingsRepository)
      HomeViewFactory.createHomeView(
        getProfileUseCase: getProfileUseCase,
        fetchTermsUseCase: fetchTermsUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase,
        fetchContactsUseCase: fetchContactsUseCase,
        blockContactsUseCase: blockContactsUseCase,
        getContactsSyncTimeUseCase: getContactsSyncTimeUseCase
      )
      
    case .onboarding:
      OnboardingViewFactory.createOnboardingView()
      
      // MARK: - 설정
    case let .settingsWebView(title, uri):
      SettingsViewFactory.createSettingsWebView(title: title, uri: uri)
      
      // MARK: - 매칭 메인
    case .matchMain:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchMainUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase(repository: matchesRepository)
      let acceptMatchUseCase = UseCaseFactory.createAcceptMatchUseCase(repository: matchesRepository)
      MatchMainViewFactory.createMatchMainView(
        getMatchProfileBasicUseCase: getMatchMainUseCase,
        acceptMatchUseCase: acceptMatchUseCase
      )
      
      // MARK: - 매칭 상세
    case .matchProfileBasic:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchProfileBasicUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase(repository: matchesRepository)
      let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchProfileBasicView(
        getMatchProfileBasicUseCase: getMatchProfileBasicUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
      
    case .matchValueTalk:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchValueTalkUseCase = UseCaseFactory.createGetMatchValueTalkUseCase(repository: matchesRepository)
      let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase(repository: matchesRepository)
      MatchDetailViewFactory.createMatchValueTalkView(
        getMatchValueTalkUseCase: getMatchValueTalkUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
      
    case .matchValuePick:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let getMatchValuePickUseCase = UseCaseFactory.createGetMatchValuePickUseCase(repository: matchesRepository)
      let acceptMatchUseCase = UseCaseFactory.createAcceptMatchUseCase(repository: matchesRepository)
      let refuseMatchUseCase = UseCaseFactory.createRefuseMatchUseCase(repository: matchesRepository)
      let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase(repository: matchesRepository)
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
      
    case let .termsWebView(title, url):
      SignUpViewFactory.createTermsWebView(title: title, url: url)
      
    case .checkPremission:
      let notificationPermissionUseCase = UseCaseFactory.createNotificationPermissionUseCase()
      let cameraPermissionUseCase = UseCaseFactory.createCameraPermissionUseCase()
      let photoPermissionUseCase = UseCaseFactory.createPhotoPermissionUseCase()
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      SignUpViewFactory.createPermissionRequestView(
        cameraPermissionUseCase: cameraPermissionUseCase,
        photoPermissionUseCase: photoPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase
      )
      
    case .AvoidContactsGuide:
      let blockcontactsrepository = repositoryFactory.createBlockContactsRepository()
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      let fetchContactsUseCase = UseCaseFactory.createFetchContactsUseCase()
      let blockContactsUseCase = UseCaseFactory.createBlockContactsUseCase(repository: blockcontactsrepository)
      SignUpViewFactory.createAvoidContactsGuideView(
        contactsPermissionUseCase: contactsPermissionUseCase,
        fetchContactsUseCase: fetchContactsUseCase,
        blockContactsUseCase: blockContactsUseCase
      )
      
    case .completeSignUp:
      SignUpViewFactory.createCompleteSignUpView()
      
    case .signUp:
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      let cameraPermissionUseCase = UseCaseFactory.createCameraPermissionUseCase()
      let photoPermissionUseCase = UseCaseFactory.createPhotoPermissionUseCase()
      let notificationPermissionUseCase = UseCaseFactory.createNotificationPermissionUseCase()
      SignUpViewFactory.createPermissionRequestView(
        cameraPermissionUseCase: cameraPermissionUseCase,
        photoPermissionUseCase: photoPermissionUseCase,
        contactsPermissionUseCase: contactsPermissionUseCase,
        notificationPermissionUseCase: notificationPermissionUseCase
      )
      
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
      
    case .waitingAISummary:
      let sseRepository = repositoryFactory.createSSERepository()
      let getAISummaryUseCase = UseCaseFactory.createGetAISummaryUseCase(repository: sseRepository)
      let finishAISummaryUseCase = UseCaseFactory.createFinishAISummaryUseCase(repository: sseRepository)
      SignUpViewFactory.createWaitingAISummaryView(
        getAISummaryUseCase: getAISummaryUseCase,
        finishAISummaryUseCase: finishAISummaryUseCase
      )
      
    case .completeCreateProfile:
      SignUpViewFactory.createCompleteCreateProfileView()
      
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
      
    case .splash:
      let commonRepository = repositoryFactory.createCommonRepository()
      let loginRepository = repositoryFactory.createLoginRepository()
      let getServerStatusUseCase = UseCaseFactory.createGetServerStatusUseCase(repository: commonRepository)
      let socialLoginUseCase = UseCaseFactory.createSocialLoginUseCase(repository: loginRepository)
      SplashViewFactory.createSplashView(
        getServerStatusUseCase: getServerStatusUseCase,
        socialLoginUseCase: socialLoginUseCase
      )
      
    case let .reportUser(nickname):
      let reportsRepository = repositoryFactory.createReportsRepository()
      let reportUserUseCase = UseCaseFactory.createReportUserUseCase(repository: reportsRepository)
      ReportUserViewFactory.createReportUserView(nickname: nickname, reportUserUseCase: reportUserUseCase)
    }
  }
}
