//
//  FinishAISummaryUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol FinishAISummaryUseCase {
  func execute() async throws -> VoidModel
}

final class FinishAISummaryUseCaseImpl: FinishAISummaryUseCase {
  private let repository: SSERepositoryInterface
  
  init(repository: SSERepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    try await repository.disconnectSse()
  }
}
