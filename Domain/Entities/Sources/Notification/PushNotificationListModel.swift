//
//  PushNotificationListModel.swift
//  Entities
//
//  Created by summercat on 2/27/25.
//

public struct PushNotificationListModel {
  public let page: Int
  public let totalPages: Int
  public let notifications: [PushNotificationModel]
  
  public init(
    page: Int,
    totalPages: Int,
    notifications: [PushNotificationModel]
  ) {
    self.page = page
    self.totalPages = totalPages
    self.notifications = notifications
  }
}
