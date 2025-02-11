//
//  GetMatchValueTalkUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities
import RepositoryInterfaces

public protocol GetMatchValueTalkUseCase {
  func execute() async throws -> MatchValueTalkModel
}

final class GetMatchValueTalkUseCaseImpl: GetMatchValueTalkUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> MatchValueTalkModel {
    try await repository.getMatchValueTalks()
  }
}
