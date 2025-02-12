//
//  AcceptMatchUseCase.swift
//  UseCases
//
//  Created by summercat on 2/12/25.
//

import Entities
import RepositoryInterfaces

public protocol AcceptMatchUseCase {
  func execute() async throws -> VoidModel
}

final class AcceptMatchUseCaseImpl: AcceptMatchUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    try await repository.acceptMatch()
  }
}
