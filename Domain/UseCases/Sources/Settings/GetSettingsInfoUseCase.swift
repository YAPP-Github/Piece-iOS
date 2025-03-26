//
//  GetSettingsInfoUseCase.swift
//  UseCases
//
//  Created by summercat on 3/27/25.
//

import Entities
import RepositoryInterfaces

public protocol GetSettingsInfoUseCase {
  func execute() async throws -> SettingsInfoModel
}

final class GetSettingsInfoUseCaseImpl: GetSettingsInfoUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> SettingsInfoModel {
    try await repository.getSettingsInfo()
  }
}
