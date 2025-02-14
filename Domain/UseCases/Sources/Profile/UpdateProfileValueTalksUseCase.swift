//
//  UpdateProfileValueTalksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/13/25.
//

import Entities
import RepositoryInterfaces

public protocol UpdateProfileValueTalksUseCase {
  func execute(valueTalks: [ProfileValueTalkModel]) async throws -> VoidModel
}

final class UpdateProfileValueTalksUseCaseImpl: UpdateProfileValueTalksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(valueTalks: [ProfileValueTalkModel]) async throws -> VoidModel {
    try await repository.updateProfileValueTalks(valueTalks)
  }
}

