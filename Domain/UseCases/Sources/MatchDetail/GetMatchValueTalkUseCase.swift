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
      shortIntroduction: "안녕하세요",
      nickname: "닉네임",
      valueTalks: [
        ValueTalkModel(category: "카테고리1", summary: "요약1", answer: "답변1"),
        ValueTalkModel(category: "카테고리2", summary: "요약2", answer: "답변2"),
      ]
    )
  }
}
