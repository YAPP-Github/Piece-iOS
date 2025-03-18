//
//  NotificationModel.swift
//  Entities
//
//  Created by summercat on 2/27/25.
//

public struct NotificationModel {
  public let id: Int
  public let type: NotificationType
  public let title: String
  public let body: String
  public let dateTime: String
  public let isRead: Bool
  
  public init(
    id: Int,
    type: NotificationType,
    title: String,
    body: String,
    dateTime: String,
    isRead: Bool
  ) {
    self.id = id
    self.type = type
    self.title = title
    self.body = body
    self.dateTime = dateTime
    self.isRead = isRead
  }
}
