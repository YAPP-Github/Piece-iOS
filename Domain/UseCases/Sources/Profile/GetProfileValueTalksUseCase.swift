//
//  GetProfileValueTalksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/13/25.
//

import Entities
import RepositoryInterfaces

public protocol GetProfileValueTalksUseCase {
  func execute() async throws -> [ProfileValueTalkModel]
}

final class GetProfileValueTalksUseCaseImpl: GetProfileValueTalksUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> [ProfileValueTalkModel] {
    try await repository.getProfileValueTalks()
  }
}
