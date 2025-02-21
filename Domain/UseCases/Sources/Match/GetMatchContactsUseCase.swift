//
//  GetMatchContactsUseCase.swift
//  UseCases
//
//  Created by summercat on 2/20/25.
//

import Entities
import RepositoryInterfaces

public protocol GetMatchContactsUseCase {
  func execute() async throws -> MatchContactsModel
}

final class GetMatchContactsUseCaseImpl: GetMatchContactsUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> MatchContactsModel {
    try await repository.getMatchContacts()
  }
}
