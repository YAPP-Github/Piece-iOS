//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation
import Repository

public struct UseCaseFactory {
  public static func createFetchTermsUseCase() -> FetchTermsUseCase {
    FetchTermsUseCaseImpl(repository: TermsRepository())
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
