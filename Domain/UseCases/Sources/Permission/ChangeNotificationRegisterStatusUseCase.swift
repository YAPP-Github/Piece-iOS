//
//  ChangeNotificationRegisterStatusUseCase.swift
//  UseCases
//
//  Created by summercat on 3/27/25.
//

import UIKit

public protocol ChangeNotificationRegisterStatusUseCase {
  func execute(isEnabled: Bool) async
}

final class ChangeNotificationRegisterStatusUseCaseImpl: ChangeNotificationRegisterStatusUseCase {  
  func execute(isEnabled: Bool) async {
    if isEnabled {
      await UIApplication.shared.registerForRemoteNotifications()
    } else {
      await UIApplication.shared.unregisterForRemoteNotifications()
    }
  }
}
