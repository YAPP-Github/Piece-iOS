//
//  NotificationResponseDTO.swift
//  DTO
//
//  Created by summercat on 3/15/25.
//

import Entities
import Foundation

public struct NotificationResponseDTO: Decodable {
  public let notificationType: NotificationType
  public let notificationId: Int
  public let isRead: Bool
  public let title: String
  public let body: String
  public let dateTime: String
}

public extension NotificationResponseDTO {
  func toDomain() -> NotificationModel {
    return NotificationModel(
      id: notificationId,
      type: notificationType,
      title: title,
      body: body,
      dateTime: dateTime,
      isRead: isRead
    )
  }
}
