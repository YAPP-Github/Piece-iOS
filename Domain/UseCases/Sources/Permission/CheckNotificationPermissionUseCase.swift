//
//  CheckNotificationPermissionUseCase.swift
//  UseCases
//
//  Created by summercat on 3/26/25.
//

import UserNotifications

public protocol CheckNotificationPermissionUseCase {
  func execute() async -> UNAuthorizationStatus
}

final class CheckNotificationPermissionUseCaseImpl: CheckNotificationPermissionUseCase {
  private let userNotificationCenter: UNUserNotificationCenter
  
  init(
    userNotificationCenter: UNUserNotificationCenter = .current()
  ) {
    self.userNotificationCenter = userNotificationCenter
  }
  
  func execute() async -> UNAuthorizationStatus {
    return await userNotificationCenter.notificationSettings().authorizationStatus
  }
}
