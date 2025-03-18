//
//  NotificationViewFactory.swift
//  NotificationList
//
//  Created by summercat on 3/19/25.
//

import SwiftUI
import UseCases

public struct NotificationViewFactory {
  @ViewBuilder
  public static func createNotificationListView(getNotificationsUseCase: GetNotificationsUseCase) -> some View {
    NotificationListView(getNotificationsUseCase: getNotificationsUseCase)
  }
}
