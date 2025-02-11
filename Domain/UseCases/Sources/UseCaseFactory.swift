//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation
import RepositoryInterfaces

public struct UseCaseFactory {
  public static func createContactsPermissionUseCase() -> ContactsPermissionUseCase {
    ContactsPermissionUseCaseImpl()
  }
  public static func createFetchTermsUseCase(repository: TermsRepositoryInterfaces) -> FetchTermsUseCase {
    FetchTermsUseCaseImpl(repository: repository)
  }
  
  // MARK: - Profile
  
  public static func createGetProfileUseCase(repository: ProfileRepositoryInterface) -> GetProfileUseCase {
    GetProfileUseCaseImpl(repository: repository)
  }
  public static func createGetMatchProfileBasicUseCase() -> GetMatchProfileBasicUseCase {
    GetMatchProfileBasicUseCaseImpl()
  }
  
  public static func createGetMatchValueTalkUseCase() -> GetMatchValueTalkUseCase {
    GetMatchValueTalkUseCaseImpl()
  }
  
  public static func createGetMatchValuePickUseCase() -> GetMatchValuePickUseCase {
    GetMatchValuePickUseCaseImpl()
  }
  
  public static func createProfileUseCase(repository: ProfileRepositoryInterface) -> CreateProfileUseCase {
    CreateProfileUseCaseImpl(repository: repository)
  }
  
  public static func createGetMatchPhotoUseCase() -> GetMatchPhotoUseCase {
    GetMatchPhotoUseCaseImpl()
  }
  
  public static func createGetValueTalksUseCase(repository: ValueTalksRepositoryInterface) -> GetValueTalksUseCase {
    GetValueTalksUseCaseImpl(repository: repository)
  }
}
