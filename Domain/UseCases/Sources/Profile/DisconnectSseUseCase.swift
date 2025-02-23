//
//  DisconnectSseUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol DisconnectSseUseCase {
  func execute() async throws -> VoidModel
}

final class DisconnectSseUseCaseImpl: DisconnectSseUseCase {
  private let repository: SSERepositoryInterface
  
  init(repository: SSERepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    try await repository.disconnectSse()
  }
}
