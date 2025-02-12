//
//  UpdateMatchValuePicksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/12/25.

import Entities
import RepositoryInterfaces

public protocol UpdateMatchValuePicksUseCase {
  func execute(valuePicks: [ValuePickModel]) async throws -> VoidModel
}

final class UpdateMatchValuePicksUseCaseImpl: UpdateMatchValuePicksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(valuePicks: [ValuePickModel]) async throws -> VoidModel {
    try await repository.updateProfileValuePicks(valuePicks)
  }
}
