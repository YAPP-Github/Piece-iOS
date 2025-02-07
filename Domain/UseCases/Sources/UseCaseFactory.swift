//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation

public struct UseCaseFactory {
  public static func createContactsPermissionUseCase() -> ContactsPermissionUseCase {
    ContactsPermissionUseCaseImpl()
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
}
