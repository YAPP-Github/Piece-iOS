//
//  NotificationPermissionUseCase.swift
//  UseCase
//
//  Created by eunseou on 1/21/25.
//

import Foundation
import UserNotifications

public protocol NotificationPermissionUseCase {
  func execute() async throws -> Bool
}

public final class NotificationPermissionUseCaseImpl: NotificationPermissionUseCase {
  private let userNotificationCenter: UNUserNotificationCenter
  private let options : UNAuthorizationOptions
  
  public init(
    userNotificationCenter: UNUserNotificationCenter = .current(),
    options: UNAuthorizationOptions = [.alert, .badge, .sound]
  ) {
    self.userNotificationCenter = userNotificationCenter
    self.options = options
  }
  
  public func execute() async throws -> Bool {
    let status = await userNotificationCenter.notificationSettings().authorizationStatus
    
    switch status {
    case .notDetermined:
      return try await userNotificationCenter.requestAuthorization(options: options)
    case .authorized, .provisional:
      return true
    case .denied, .ephemeral:
      return false
    @unknown default:
      return false
    }
  }
}
