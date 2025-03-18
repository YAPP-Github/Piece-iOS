//
// NotificationListViewModel.swift
// NotificationList
//
// Created by summercat on 2025/02/26.
//

import Foundation
import UseCases

@MainActor
@Observable
final class NotificationListViewModel {
  enum Action {
    case loadNotifications
  }
  
  private(set) var notifications: [NotificationItemModel] = []
  @ObservationIgnored private(set) var isEnd = false
  private(set) var error: Error?
  
  private let getNotificationsUseCase: GetNotificationsUseCase
  
  init(getNotificationsUseCase: GetNotificationsUseCase) {
    self.getNotificationsUseCase = getNotificationsUseCase
    loadNotifications()
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .loadNotifications:
      loadNotifications()
    }
  }
  
  private func loadNotifications() {
    if isEnd { return }
    
    Task {
      do {
        let result = try await getNotificationsUseCase.execute()
        notifications.append(
          contentsOf: result.notifications.map {
            NotificationItemModel(
              id: $0.id,
              type: $0.type,
              title: $0.title,
              body: $0.body,
              dateTime: $0.dateTime,
              isRead: $0.isRead
            )
          })
        isEnd = result.isEnd
      } catch {
        self.error = error
      }
    }
  }
}
