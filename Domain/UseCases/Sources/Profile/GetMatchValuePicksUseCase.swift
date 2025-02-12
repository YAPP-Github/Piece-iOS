//
//  GetMatchValuePicksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/12/25.
//

import Entities
import RepositoryInterfaces

public protocol GetMatchValuePicksUseCase {
  func execute() async throws -> [ValuePickModel]
}

final class GetMatchValuePicksUseCaseImpl: GetMatchValuePicksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> [ValuePickModel] {
    try await repository.getProfileValuePicks()
  }
}

