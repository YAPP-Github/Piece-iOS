//
//  ReadNotificationUseCase.swift
//  UseCases
//
//  Created by summercat on 3/19/25.
//

import Entities
import RepositoryInterfaces

public protocol ReadNotificationUseCase {
  func execute(id: Int) async throws -> VoidModel
}

final class ReadNotificationUseCaseImpl: ReadNotificationUseCase {
  private let repository: NotificationRepositoryInterface
  
  init(repository: NotificationRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(id: Int) async throws -> VoidModel {
    try await repository.readNotification(id: id)
  }
}

