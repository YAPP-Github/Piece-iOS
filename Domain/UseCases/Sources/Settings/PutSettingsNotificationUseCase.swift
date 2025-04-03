//
//  PutSettingsNotificationUseCase.swift
//  UseCases
//
//  Created by summercat on 3/27/25.
//

import Entities
import RepositoryInterfaces

public protocol PutSettingsNotificationUseCase {
  func execute(isEnabled: Bool) async throws -> VoidModel
}

final class PutSettingsNotificationUseCaseImpl: PutSettingsNotificationUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(isEnabled: Bool) async throws -> VoidModel {
    return try await repository.putSettingsNotification(isEnabled: isEnabled)
  }
}
