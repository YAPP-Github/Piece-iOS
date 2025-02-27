//
//  PushNotificationModel.swift
//  Entities
//
//  Created by summercat on 2/27/25.
//

public struct PushNotificationModel {
  public let id: Int
  public let type: PushNotificationType
  public let title: String
  public let body: String
  public let dateTime: String
  public let isRead: Bool
  
  public init(
    id: Int,
    type: PushNotificationType,
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
