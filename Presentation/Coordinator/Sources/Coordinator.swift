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
import MatchingMain
import NotificationList
import Splash
import Settings
import ReportUser
import MatchResult
import PreviewProfile

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
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let termsRepository = repositoryFactory.createTermsRepository()
      let blockContactsRepository = repositoryFactory.createBlockContactsRepository()
      let settingsRepository = repositoryFactory.createSettingsRepository()
      let userRepository = repositoryFactory.createUserRepository()
      // profile
      let getProfileUseCase = UseCaseFactory.createGetProfileUseCase(repository: profileRepository)
      // matchMain
      let getUserInfoUseCase = UseCaseFactory.createGetUserInfoUseCase(repository: userRepository)
      let acceptMatchUseCase = UseCaseFactory.createAcceptMatchUseCase(repository: matchesRepository)
      let getMatchesInfoUseCase = UseCaseFactory.createGetMatchesInfoUseCase(repository: matchesRepository)
      let getUserRejectUseCase = UseCaseFactory.createGetUserRejectUseCase(repository: matchesRepository)
      let patchMatchesCheckPieceUseCase = UseCaseFactory.createPatchMatchesCheckPieceUseCase(repository: matchesRepository)
      // setting
      let fetchTermsUseCase = UseCaseFactory.createFetchTermsUseCase(repository: termsRepository)
      let notificationPermissionUseCase = UseCaseFactory.createNotificationPermissionUseCase()
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      let fetchContactsUseCase = UseCaseFactory.createFetchContactsUseCase()
      let blockContactsUseCase = UseCaseFactory.createBlockContactsUseCase(repository: blockContactsRepository)
      let getContactsSyncTimeUseCase = UseCaseFactory.createGetContactsSyncTimeUseCase(repository: settingsRepository)
      let patchLogoutUseCase = UseCaseFactory.createLogoutUseCase(repository: settingsRepository)
      HomeViewFactory.createHomeView(
        getProfileUseCase: getProfileUseCase,
        getUserInfoUseCase: getUserInfoUseCase,
        acceptMatchUseCase: acceptMatchUseCase,
        getMatchesInfoUseCase: getMatchesInfoUseCase,
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
      
    case .onboarding:
      OnboardingViewFactory.createOnboardingView()
      
      // MARK: - 설정
    case let .settingsWebView(title, uri):
      SettingsViewFactory.createSettingsWebView(title: title, uri: uri)
      
      // MARK: - 매칭 메인
    case .matchMain:
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let userRepository = repositoryFactory.createUserRepository()
      let getUserInfoUseCase = UseCaseFactory.createGetUserInfoUseCase(repository: userRepository)
      let acceptMatchUseCase = UseCaseFactory.createAcceptMatchUseCase(repository: matchesRepository)
      let getMatchesInfoUseCase = UseCaseFactory.createGetMatchesInfoUseCase(repository: matchesRepository)
      let getUserRejectUseCase = UseCaseFactory.createGetUserRejectUseCase(repository: matchesRepository)
      let patchMatchesCheckPieceUseCase = UseCaseFactory.createPatchMatchesCheckPieceUseCase(repository: matchesRepository)
      MatchMainViewFactory.createMatchMainView(
        getUserInfoUseCase: getUserInfoUseCase,
        acceptMatchUseCase: acceptMatchUseCase,
        getMatchesInfoUseCase: getMatchesInfoUseCase,
        getUserRejectUseCase: getUserRejectUseCase,
        patchMatchesCheckPieceUseCase: patchMatchesCheckPieceUseCase
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
      
      // MARK: - 매칭 결과
    case let .matchResult(nickname): // 연락처 공개
      let matchesRepository = repositoryFactory.createMatchesRepository()
      let matchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase(repository: matchesRepository)
      let matchContactsUseCase = UseCaseFactory.createGetMatchContactsUseCase(repository: matchesRepository)
      
      MatchResultViewFactory.createMatchResultView(
        nickname: nickname,
        getMatchPhotoUseCase: matchPhotoUseCase,
        getMatchContactsUseCase: matchContactsUseCase
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
      
    case .createProfile:
      let checkNicknameRepositoty = repositoryFactory.createCheckNicknameRepository()
      let uploadProfileImageRepository = repositoryFactory.createUploadProfileImageRepository()
      let valueTalksRepository = repositoryFactory.createValueTalksRepository()
      let valuePicksRepository = repositoryFactory.createValuePicksRepository()
      let checkNicknameUseCase = UseCaseFactory.createCheckNicknameUseCase(repository: checkNicknameRepositoty)
      let uploadProfileImageUseCase = UseCaseFactory.createUploadProfileImageUseCase(repository: uploadProfileImageRepository)
      let getValueTalksUseCase = UseCaseFactory.createGetValueTalksUseCase(repository: valueTalksRepository)
      let getValuePicksUseCase = UseCaseFactory.createGetValuePicksUseCase(repository: valuePicksRepository)
      SignUpViewFactory.createProfileContainerView(
        checkNicknameUseCase: checkNicknameUseCase,
        uploadProfileImageUseCase: uploadProfileImageUseCase,
        getValueTalksUseCase: getValueTalksUseCase,
        getValuePicksUseCase: getValuePicksUseCase
      )
      
    case let .waitingAISummary(profile):
      let profileRepository = repositoryFactory.createProfileRepository()
      let createProfileUseCase = UseCaseFactory.createProfileUseCase(repository: profileRepository)
      SignUpViewFactory.createWaitingAISummaryView(
        profile: profile,
        createProfileUseCase: createProfileUseCase
      )
      
    case .completeCreateProfile:
      SignUpViewFactory.createCompleteCreateProfileView()
      
      // MARK: - Profile
    case .editValueTalk:
      let profileRepository = repositoryFactory.createProfileRepository()
      let sseRepository = repositoryFactory.createSseRepository()
      let getProfileValueTalksUseCase = UseCaseFactory.createGetProfileValueTalksUseCase(repository: profileRepository)
      let updateProfileValueTalksUseCase = UseCaseFactory.createUpdateProfileValueTalksUseCase(repository: profileRepository)
      let connectSseUseCase = UseCaseFactory.createConnectSseUseCase(repository: sseRepository)
      let disconnectSseUseCase = UseCaseFactory.createDisconnectSseUseCase(repository: sseRepository)
      EditValueTalkViewFactory.createEditValueTalkViewFactory(
        getProfileValueTalksUseCase: getProfileValueTalksUseCase,
        updateProfileValueTalksUseCase: updateProfileValueTalksUseCase,
        connectSseUseCase: connectSseUseCase,
        disconnectSseUseCase: disconnectSseUseCase
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
      
    case let .withdrawConfirm(reason):
      let withdrawRepository = repositoryFactory.createWithdrawRepository()
      let deleteUserAccountUseCase = UseCaseFactory.createDeleteUserAccountUseCase(repository: withdrawRepository)
      let appleAuthServiceUseCase = UseCaseFactory.createAppleAuthServiceUseCase()
      WithdrawViewFactory.createWithdrawConfirmView(
        deleteUserAccountUseCase: deleteUserAccountUseCase,
        appleAuthServiceUseCase: appleAuthServiceUseCase,
        reason: reason
      )
      
    case .splash:
      let userRepository = repositoryFactory.createUserRepository()
      let getUserInfoUseCase = UseCaseFactory.createGetUserInfoUseCase(repository: userRepository)
      SplashViewFactory.createSplashView(
        getUserInfoUseCase: getUserInfoUseCase
      )
      
    case let .reportUser(nickname):
      let reportsRepository = repositoryFactory.createReportsRepository()
      let reportUserUseCase = UseCaseFactory.createReportUserUseCase(repository: reportsRepository)
      ReportUserViewFactory.createReportUserView(nickname: nickname, reportUserUseCase: reportUserUseCase)
      
      // MARK: - 프로필 미리보기
    case .previewProfileBasic:
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileBasicUseCase = UseCaseFactory.createGetProfileUseCase(repository: profileRepository)
      PreviewProfileViewFactory.createMatchProfileBasicView(
        getProfileBasicUseCase: getProfileBasicUseCase
      )
      
    case let .previewProfileValueTalks(nickname, description, imageUri):
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileValueTalksUseCase = UseCaseFactory.createGetProfileValueTalksUseCase(repository: profileRepository)
      PreviewProfileViewFactory.createMatchValueTalkView(
        nickname: nickname,
        description: description,
        imageUri: imageUri,
        getProfileValueTalksUseCase: getProfileValueTalksUseCase
      )
      
    case let .previewProfileValuePicks(nickname, description, imageUri):
      let profileRepository = repositoryFactory.createProfileRepository()
      let getProfileValuePicksUseCase = UseCaseFactory.createGetProfileValuePicksUseCase(repository: profileRepository)
      PreviewProfileViewFactory.createMatchValuePickView(
        nickname: nickname,
        description: description,
        imageUri: imageUri,
        getProfileValuePicksUseCase: getProfileValuePicksUseCase
      )
      
      // MARK: - 알림
    case .notificationList:
      let notificationRepository = repositoryFactory.createNotificationRepository()
      let getNotificationsUseCase = UseCaseFactory.createGetNotificationsUseCase(repository: notificationRepository)
      NotificationViewFactory.createNotificationListView(getNotificationsUseCase: getNotificationsUseCase)
    }
  }
}
