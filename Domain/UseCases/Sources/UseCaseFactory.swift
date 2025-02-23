//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation
import RepositoryInterfaces

public struct UseCaseFactory {
  public static func createGetServerStatusUseCase(repository: CommonRepositoryInterface) -> GetServerStatusUseCase {
    GetServerStatusUseCaseImpl(repository: repository)
  }
  
  // MARK: - 권한
  public static func createContactsPermissionUseCase() -> ContactsPermissionUseCase {
    ContactsPermissionUseCaseImpl()
  }
  
  public static func createNotificationPermissionUseCase() -> NotificationPermissionUseCase {
    NotificationPermissionUseCaseImpl()
  }
  
  public static func createCameraPermissionUseCase() -> CameraPermissionUseCase {
    CameraPermissionUseCaseImpl()
  }
  
  public static func createPhotoPermissionUseCase() -> PhotoPermissionUseCase {
    PhotoPermissionUseCaseImpl()
  }
  
  // MARK: - 로그인
  
  public static func createSocialLoginUseCase(repository: LoginRepositoryInterfaces) -> SocialLoginUseCase {
    SocialLoginUseCaseImpl(repository: repository)
  }
  
  public static func createAppleAuthServiceUseCase() -> AppleAuthServiceUseCase {
    AppleAuthServiceUseCaseImpl()
  }
  
  public static func createSendSMSCodeUseCase(repository: LoginRepositoryInterfaces) -> SendSMSCodeUseCase {
    SendSMSCodeUseCaseImpl(repository: repository)
  }
  
  public static func createVerifySMSCodeUseCase(repository: LoginRepositoryInterfaces) -> VerifySMSCodeUseCase {
    VerifySMSCodeUseCaseImpl(repository: repository)
  }
  
  public static func createFetchTermsUseCase(repository: TermsRepositoryInterfaces) -> FetchTermsUseCase {
    FetchTermsUseCaseImpl(repository: repository)
  }
  
  
  public static func createCheckNicknameUseCase(repository: CheckNinknameRepositoryInterface) -> CheckNicknameUseCase {
    CheckNicknameUseCaseImpl(repository: repository)
  }
  
  public static func createFetchContactsUseCase() -> FetchContactsUseCase {
    FetchContactsUseCaseImpl()
  }
  
  public static func createBlockContactsUseCase(repository: BlockContactsRepositoryInterface) -> BlockContactsUseCase {
    BlockContactsUseCaseImpl(repository: repository)
  }
  
  // MARK: - Profile
  public static func createUploadProfileImageUseCase(repository: ProfileRepositoryInterface) -> UploadProfileImageUseCase {
    UploadProfileImageUseCaseImpl(repository: repository)
  }
  
  public static func createGetProfileUseCase(repository: ProfileRepositoryInterface) -> GetProfileBasicUseCase {
    GetProfileUseCaseImpl(repository: repository)
  }
  
  public static func createProfileUseCase(repository: ProfileRepositoryInterface) -> CreateProfileUseCase {
    CreateProfileUseCaseImpl(repository: repository)
  }
  
  public static func createGetValueTalksUseCase(repository: ValueTalksRepositoryInterface) -> GetValueTalksUseCase {
    GetValueTalksUseCaseImpl(repository: repository)
  }
  
  public static func createGetValuePicksUseCase(repository: ValuePicksRepositoryInterface) -> GetValuePicksUseCase {
    GetValuePicksUseCaseImpl(repository: repository)
  }
  
  public static func createGetProfileValueTalksUseCase(repository: ProfileRepositoryInterface) -> GetProfileValueTalksUseCase {
    GetProfileValueTalksUseCaseImpl(repository: repository)
  }
  
  public static func createUpdateProfileValueTalksUseCase(repository: ProfileRepositoryInterface) -> UpdateProfileValueTalksUseCase {
    UpdateProfileValueTalksUseCaseImpl(repository: repository)
  }
  
  public static func createGetProfileValuePicksUseCase(repository: ProfileRepositoryInterface) -> GetProfileValuePicksUseCase {
    GetProfileValuePicksUseCaseImpl(repository: repository)
  }
  
  public static func createUpdateProfileValuePicksUseCase(repository: ProfileRepositoryInterface) -> UpdateProfileValuePicksUseCase {
    UpdateProfileValuePicksUseCaseImpl(repository: repository)
  }
  
  public static func createUpdateProfileValueTalkSummaryUseCase(repository: ProfileRepositoryInterface) -> UpdateProfileValueTalkSummaryUseCase {
    UpdateProfileValueTalkSummaryUseCaseImpl(repository: repository)
  }
  
  // MARK: - 매칭
  
  public static func createAcceptMatchUseCase(repository: MatchesRepositoryInterface) -> AcceptMatchUseCase {
    AcceptMatchUseCaseImpl(repository: repository)
  }
  
  public static func createRefuseMatchUseCase(repository: MatchesRepositoryInterface) -> RefuseMatchUseCase {
    RefuseMatchUseCaseImpl(repository: repository)
  }
  
  // MARK: - 매칭 상세
  public static func createGetMatchProfileBasicUseCase(repository: MatchesRepositoryInterface) -> GetMatchProfileBasicUseCase {
    GetMatchProfileBasicUseCaseImpl(repository: repository)
  }
  
  public static func createGetMatchValueTalkUseCase(repository: MatchesRepositoryInterface) -> GetMatchValueTalkUseCase {
    GetMatchValueTalkUseCaseImpl(repository: repository)
  }
  
  public static func createGetMatchValuePickUseCase(repository: MatchesRepositoryInterface) -> GetMatchValuePickUseCase {
    GetMatchValuePickUseCaseImpl(repository: repository)
  }
  
  public static func createGetMatchPhotoUseCase(repository: MatchesRepositoryInterface) -> GetMatchPhotoUseCase {
    GetMatchPhotoUseCaseImpl(repository: repository)
  }
  
  public static func createGetMatchContactsUseCase(repository: MatchesRepositoryInterface) -> GetMatchContactsUseCase {
    GetMatchContactsUseCaseImpl(repository: repository)
  }
  
  public static func createReportUserUseCase(repository: ReportsRepositoryInterface) -> ReportUserUseCase {
    ReportUserUseCaseImpl(repository: repository)
  }
  
  public static func createBlockUserUseCase(repository: MatchesRepositoryInterface) -> BlockUserUseCase {
    BlockUserUseCaseImpl(repository: repository)
  }
  
  // MARK: - AI요약 SSE
  public static func createConnectSseUseCase(repository: SSERepositoryInterface) -> ConnectSseUseCase {
    ConnectSseUseCaseImpl(repository: repository)
  }
  
  public static func createDisconnectSseUseCase(repository: SSERepositoryInterface) -> DisconnectSseUseCase {
    DisconnectSseUseCaseImpl(repository: repository)
  }
  
  // MARK: - 설정
  public static func createGetContactsSyncTimeUseCase(repository: SettingsRepositoryInterface) -> GetContactsSyncTimeUseCase {
    GetContactsSyncTimeUseCaseImpl(repository: repository)
  }
}
