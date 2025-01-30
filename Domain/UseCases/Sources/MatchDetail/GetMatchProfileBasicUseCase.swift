//
//  GetMatchProfileBasicUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities

public protocol GetMatchProfileBasicUseCase {
  func execute() async throws -> MatchProfileBasicModel
}

final class GetMatchProfileBasicUseCaseImpl: GetMatchProfileBasicUseCase {
  func execute() async throws -> MatchProfileBasicModel {
    // TODO: - API 연결 후 수정
    return MatchProfileBasicModel(
      id: 0,
      shortIntroduction: "안녕하세요",
      nickname: "티모",
      age: 28,
      birthYear: "00",
      height: 180,
      weight: 74,
      location: "서울특별시",
      job: "무직",
      smokingStatus: "흡연"
    )
  }
}
