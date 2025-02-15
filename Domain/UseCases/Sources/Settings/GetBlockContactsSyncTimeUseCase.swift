//
//  GetBlockContactsSyncTimeUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol GetBlockContactsSyncTimeUseCase {
  func execute() async throws -> BlockContactsSyncTimeModel
}

final class GetBlockContactsSyncTimeUseCaseImpl: GetBlockContactsSyncTimeUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> BlockContactsSyncTimeModel {
    try await repository.getBlockContactsSyncTime()
  }
}
