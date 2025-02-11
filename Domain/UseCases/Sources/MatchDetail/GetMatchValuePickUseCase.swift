//
//  GetMatchValuePickUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities
import RepositoryInterfaces

public protocol GetMatchValuePickUseCase {
  func execute() async throws -> MatchValuePickModel
}

final class GetMatchValuePickUseCaseImpl: GetMatchValuePickUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> MatchValuePickModel {
    try await repository.getMatchValuePicks()
  }
}
