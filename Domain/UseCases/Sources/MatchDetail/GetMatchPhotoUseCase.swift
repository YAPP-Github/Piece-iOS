//
//  GetMatchPhotoUseCase.swift
//  UseCases
//
//  Created by summercat on 2/6/25.
//

import Entities
import RepositoryInterfaces

public protocol GetMatchPhotoUseCase {
  func execute() async throws -> String
}

final class GetMatchPhotoUseCaseImpl: GetMatchPhotoUseCase {
  private let repository: MatchesRepositoryInterface
  
  init(repository: MatchesRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> String {
    try await repository.getMatchImage().imageUri
  }
}
