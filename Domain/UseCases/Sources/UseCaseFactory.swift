//
//  UseCaseFactory.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Foundation

public struct UseCaseFactory {
  public static func createGetMatchProfileBasicUseCase() -> GetMatchProfileBasicUseCase {
    GetMatchProfileBasicUseCaseImpl()
  }
  
  public static func createGetMatchValueTalkUseCase() -> GetMatchValueTalkUseCase {
    GetMatchValueTalkUseCaseImpl()
  }
}
