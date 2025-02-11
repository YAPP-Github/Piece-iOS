//
//  GetValuePicksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/10/25.
//

import Entities
import RepositoryInterfaces

public protocol GetValuePicksUseCase {
  func execute() async throws -> [ValuePickModel]
}

final class GetValuePicksUseCaseImpl: GetValuePicksUseCase {
  private let repository: ValuePicksRepositoryInterface
  
  init(repository: ValuePicksRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> [ValuePickModel] {
    try await repository.getValuePicks()
  }
}
