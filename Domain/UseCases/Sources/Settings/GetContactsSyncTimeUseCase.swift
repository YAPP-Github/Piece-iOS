//
//  GetContactsSyncTimeUseCase.swift
//  UseCases
//
//  Created by summercat on 2/19/25.
//

import Entities
import RepositoryInterfaces

public protocol GetContactsSyncTimeUseCase {
  func execute() async throws -> ContactsSyncTimeModel
}

final class GetContactsSyncTimeUseCaseImpl: GetContactsSyncTimeUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> ContactsSyncTimeModel {
    try await repository.getContactsSyncTime()
  }
}
