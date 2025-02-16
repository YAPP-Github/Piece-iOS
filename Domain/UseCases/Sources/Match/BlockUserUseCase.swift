//
//  BlockUserUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol BlockUserUseCase {
  func execute(matchId: Int) async throws -> VoidModel
}

final class BlockUserUseCaseImpl: BlockUserUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(matchId: Int) async throws -> VoidModel {
    try await repository.blockUser(matchId: matchId)
  }
}
