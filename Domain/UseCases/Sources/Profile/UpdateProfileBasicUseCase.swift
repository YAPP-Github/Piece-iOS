//
//  UpdateProfileBasicUseCase.swift
//  UseCases
//
//  Created by eunseou on 3/18/25.
//

import Entities
import RepositoryInterfaces

public protocol UpdateProfileBasicUseCase {
  func execute(profile: ProfileBasicModel) async throws -> ProfileBasicModel
}

final class UpdateProfileBasicUseCaseImpl: UpdateProfileBasicUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(profile: ProfileBasicModel) async throws -> ProfileBasicModel {
    try await repository.updateProfileBasic(profile)
  }
}
