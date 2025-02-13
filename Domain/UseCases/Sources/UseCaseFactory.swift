//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation
import RepositoryInterfaces

public struct UseCaseFactory {
  // MARK: - 권한
  public static func createContactsPermissionUseCase() -> ContactsPermissionUseCase {
    ContactsPermissionUseCaseImpl()
  }
  
  public static func createNotificationPermissionUseCase() -> NotificationPermissionUseCase {
    NotificationPermissionUseCaseImpl()
  }
  
  public static func createFetchTermsUseCase(repository: TermsRepositoryInterfaces) -> FetchTermsUseCase {
    FetchTermsUseCaseImpl(repository: repository)
  }
  

  public static func createCheckNicknameUseCase(repository: CheckNinknameRepositoryInterface) -> CheckNicknameUseCase {
    CheckNicknameUseCaseImpl(repository: repository)
  }
  
  public static func createAcceptMatchUseCase(repository: MatchesRepositoryInterface) -> AcceptMatchUseCase {
    AcceptMatchUseCaseImpl(repository: repository)
  }
  
  // MARK: - Profile
  public static func createUploadProfileImageUseCase(repository: ProfileRepositoryInterface) -> UploadProfileImageUseCase {
    UploadProfileImageUseCaseImpl(repository: repository)
  }
  
  public static func createGetProfileUseCase(repository: ProfileRepositoryInterface) -> GetProfileUseCase {
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
  
  public static func createGetMatchPhotoUseCase() -> GetMatchPhotoUseCase {
    GetMatchPhotoUseCaseImpl()
  }
}
