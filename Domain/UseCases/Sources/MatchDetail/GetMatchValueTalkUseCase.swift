//
//  GetMatchValueTalkUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities

public protocol GetMatchValueTalkUseCase {
  func execute() async throws -> MatchValueTalkModel
}

final class GetMatchValueTalkUseCaseImpl: GetMatchValueTalkUseCase {
  func execute() async throws -> MatchValueTalkModel {
    // TODO: - API 연결 후 수정
    MatchValueTalkModel(
      id: 0,
      description: "안녕하세요",
      nickname: "닉네임",
      valueTalks: [
      ]
    )
  }
}
