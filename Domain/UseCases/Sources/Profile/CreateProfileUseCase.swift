//
//  CreateProfileUseCase.swift
//  UseCases
//
//  Created by summercat on 2/9/25.
//

import Entities
import RepositoryInterfaces

public protocol CreateProfileUseCase {
  func execute(profile: ProfileModel) async throws -> PostProfileResultModel
}

final class CreateProfileUseCaseImpl: CreateProfileUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(profile: ProfileModel) async throws -> PostProfileResultModel {
    return try await repository.postProfile(profile)
  }
}
