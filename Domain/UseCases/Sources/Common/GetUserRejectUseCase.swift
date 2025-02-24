//
//  GetUserRejectUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/24/25.
//

import Entities
import RepositoryInterfaces

public protocol GetUserRejectUseCase {
  func execute() async throws -> UserRejectReasonModel
}

final class GetUserRejectUseCaseImpl: GetUserRejectUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> UserRejectReasonModel {
    try await repository.getUserRejectReason()
  }
}

