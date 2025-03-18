//
//  NotificationRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 3/15/25.
//

import Entities

public protocol NotificationRepositoryInterface {
  func getNotifications() async throws -> (notifications: [NotificationModel], isEnd: Bool)
}
