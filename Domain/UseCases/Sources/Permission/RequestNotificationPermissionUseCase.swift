//
//  RequestNotificationPermissionUseCase.swift
//  UseCases
//
//  Created by summercat on 3/26/25.
//

import UserNotifications

public protocol RequestNotificationPermissionUseCase {
  func execute() async throws -> Bool
}

final class RequestNotificationPermissionUseCaseImpl: RequestNotificationPermissionUseCase {
  private let userNotificationCenter: UNUserNotificationCenter
  private let options : UNAuthorizationOptions
  
  init(
    userNotificationCenter: UNUserNotificationCenter = .current(),
    options: UNAuthorizationOptions = [.alert, .badge, .sound]
  ) {
    self.userNotificationCenter = userNotificationCenter
    self.options = options
  }
  
  func execute() async throws -> Bool {
    return try await userNotificationCenter.requestAuthorization(options: options)
  }
}
