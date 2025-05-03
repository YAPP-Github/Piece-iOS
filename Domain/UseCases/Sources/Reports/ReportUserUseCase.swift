//
//  ReportUserUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol ReportUserUseCase {
  func execute(id: Int, reason: String) async throws -> VoidModel
}

final class ReportUserUseCaseImpl: ReportUserUseCase {
  private let repository: ReportsRepositoryInterface
  
  init(repository: ReportsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(
    id: Int,
    reason: String
  ) async throws -> VoidModel {
    try await repository.reportUser(id: id, reason: reason)
  }
}
