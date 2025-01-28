//
//  GetMatchProfileBasicUseCase.swift
//  UseCases
//
//  Created by summercat on 1/28/25.
//

import Entities

public protocol GetMatchProfileBasicUseCase {
  func execute() async throws -> MatchProfileBasicModel
}

final class GetMatchProfileBasicUseCaseImpl: GetMatchProfileBasicUseCase {
  func execute() async throws -> MatchProfileBasicModel {
    // TODO: - repository 구현 후 수정
    return MatchProfileBasicModel(
      shortIntroduce: "음악과 요리를 좋아하는",
      nickname: "수줍은 수달",
      age: 25,
      birthYear: "00",
      height: 180,
      weight: 72,
      region: "세종특별자치시",
      job: "프리랜서",
      isSmoker: false
    )
  }
}
