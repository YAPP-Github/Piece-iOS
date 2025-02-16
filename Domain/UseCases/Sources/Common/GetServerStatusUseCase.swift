//
//  GetServerStatusUseCase.swift
//  UseCases
//
//  Created by summercat on 2/15/25.
//

import Entities
import RepositoryInterfaces

public protocol GetServerStatusUseCase {
  func execute() async throws -> VoidModel
}

final class GetServerStatusUseCaseImpl: GetServerStatusUseCase {
  private let repository: CommonRepositoryInterface
  
  init(repository: CommonRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    try await repository.getServerStatus()
  }
}

