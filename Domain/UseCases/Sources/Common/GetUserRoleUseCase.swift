//
//  GetUserRole.swift
//  UseCases
//
//  Created by eunseou on 3/1/25.
//

import Entities
import RepositoryInterfaces

public protocol GetUserRoleUseCase {
  func execute() async throws -> UserRoleModel
}

final class GetUserRoleUseCaseImpl: GetUserRoleUseCase {
  private let repository: CommonRepositoryInterface
  
  init(repository: CommonRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> UserRoleModel {
    try await repository.getUserRole()
  }
}
