//
//  CheckTokenHealthUseCase.swift
//  UseCases
//
//  Created by summercat on 2/25/25.
//

import Entities
import RepositoryInterfaces

public protocol CheckTokenHealthUseCase {
  func execute(token: String) async throws -> VoidModel
}

final class CheckTokenHealthUseCaseImpl: CheckTokenHealthUseCase {
  private let repository: LoginRepositoryInterfaces
  
  init(repository: LoginRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute(token: String) async throws -> VoidModel {
    try await repository.checkTokenHealth(token: token)
  }
}
