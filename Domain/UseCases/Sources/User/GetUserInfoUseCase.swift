//
//  GetUserInfoUseCase.swift
//  UseCases
//
//  Created by summercat on 3/5/25.
//

import Entities
import RepositoryInterfaces

public protocol GetUserInfoUseCase {
  func execute() async throws -> UserInfoModel
}

final class GetUserRoleUseCaseImpl: GetUserInfoUseCase {
  private let repository: UserRepositoryInterface
  
  init(repository: UserRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> UserInfoModel {
    try await repository.getUserRole()
  }
}
