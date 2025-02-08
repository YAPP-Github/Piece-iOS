//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation

public struct UseCaseFactory {
  // MARK: - 사용자 프로필
  public static func createGetProfileUseCase() -> GetProfileUseCase {
    GetProfileUseCaseImpl()
  }
  
  // MARK: - 매칭 상세
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
