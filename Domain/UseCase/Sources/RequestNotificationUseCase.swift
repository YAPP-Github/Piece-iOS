//
//  NotificationPermissionUseCase.swift
//  UseCase
//
//  Created by eunseou on 1/21/25.
//

import Foundation
import UserNotifications

public protocol RequestNotificationUseCase {
  func execute() async throws -> Bool
}

public final class RequestNotificationUseCaseImplementation: RequestNotificationUseCase {
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
    try await userNotificationCenter.requestAuthorization(options: options)
  }
}
