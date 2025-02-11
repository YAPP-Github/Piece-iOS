//
//  GetValueTalksUseCase.swift
//  UseCases
//
//  Created by summercat on 2/9/25.
//

import Entities
import RepositoryInterfaces

public protocol GetValueTalksUseCase {
  func execute() async throws -> [ValueTalkModel]
}

final class GetValueTalksUseCaseImpl: GetValueTalksUseCase {
  private let repository: ValueTalksRepositoryInterface
  
  init(repository: ValueTalksRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> [ValueTalkModel] {
    try await repository.getValueTalks()
  }
}
