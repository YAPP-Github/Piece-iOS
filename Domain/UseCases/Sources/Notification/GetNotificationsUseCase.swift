//
//  GetNotificationsUseCase.swift
//  UseCases
//
//  Created by summercat on 3/19/25.
//

import Entities
import RepositoryInterfaces

public protocol GetNotificationsUseCase {
  func execute() async throws -> (notifications: [NotificationModel], isEnd: Bool)
}

final class GetNotificationsUseCaseImpl: GetNotificationsUseCase {
  private let repository: NotificationRepositoryInterface
  
  init(repository: NotificationRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> (notifications: [NotificationModel], isEnd: Bool) {
    try await repository.getNotifications()
  }
}
