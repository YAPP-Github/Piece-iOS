//
// NotificationListViewModel.swift
// NotificationList
//
// Created by summercat on 2025/02/26.
//

import Foundation

@Observable
final class NotificationListViewModel {
  enum Action {
  }
  
  let notifications: [NotificationItemModel]
  
  init(notifications: [NotificationItemModel]) {
    self.notifications = notifications
  }
}
