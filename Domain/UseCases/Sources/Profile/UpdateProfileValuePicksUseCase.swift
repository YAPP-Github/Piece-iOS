//
//  UpdateProfileValuePicksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/12/25.

import Entities
import RepositoryInterfaces

public protocol UpdateProfileValuePicksUseCase {
  func execute(valuePicks: [ProfileValuePickModel]) async throws -> VoidModel
}

final class UpdateMatchValuePicksUseCaseImpl: UpdateProfileValuePicksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(valuePicks: [ProfileValuePickModel]) async throws -> VoidModel {
    try await repository.updateProfileValuePicks(valuePicks)
  }
}
