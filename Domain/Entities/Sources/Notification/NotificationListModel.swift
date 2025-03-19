//
//  NotificationListModel.swift
//  Entities
//
//  Created by summercat on 2/27/25.
//

public struct NotificationListModel {
  public let page: Int
  public let totalPages: Int
  public let notifications: [NotificationModel]
  
  public init(
    page: Int,
    totalPages: Int,
    notifications: [NotificationModel]
  ) {
    self.page = page
    self.totalPages = totalPages
    self.notifications = notifications
  }
}
