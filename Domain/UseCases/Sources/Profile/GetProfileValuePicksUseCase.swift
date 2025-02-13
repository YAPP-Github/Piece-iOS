//
//  GetProfileValuePicksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/13/25.
//

import Entities
import RepositoryInterfaces

public protocol GetProfileValuePicksUseCase {
  func execute() async throws -> [ProfileValuePickModel]
}

final class GetProfileValuePicksUseCaseImpl: GetProfileValuePicksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> [ProfileValuePickModel] {
    try await repository.getProfileValuePicks()
  }
}

