//
//  PutSettingsMatchNotificationUseCase.swift
//  UseCases
//
//  Created by summercat on 3/27/25.
//

import Entities
import RepositoryInterfaces

public protocol PutSettingsMatchNotificationUseCase {
  func execute(isEnabled: Bool) async throws -> VoidModel
}

final class PutSettingsMatchNotificationUseCaseImpl: PutSettingsMatchNotificationUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(isEnabled: Bool) async throws -> VoidModel {
    return try await repository.putSettingsMatchNotification(isEnabled: isEnabled)
  }
}
