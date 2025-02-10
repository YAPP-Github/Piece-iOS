//
//  GetMatchValuePickUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities

public protocol GetMatchValuePickUseCase {
  func execute() async throws -> MatchValuePickModel
}

final class GetMatchValuePickUseCaseImpl: GetMatchValuePickUseCase {
  func execute() async throws -> MatchValuePickModel {
    // TODO: - API 연결 후 수정
    MatchValuePickModel(
      id: 0,
      description: "안녕하세요",
      nickname: "닉네임",
      valuePicks: []
    )
  }
}
