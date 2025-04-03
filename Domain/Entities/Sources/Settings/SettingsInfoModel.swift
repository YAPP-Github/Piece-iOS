//
//  SettingsInfoModel.swift
//  Entities
//
//  Created by summercat on 3/27/25.
//

public struct SettingsInfoModel {
  public let isNotificationEnabled: Bool
  public let isMatchNotificationEnabled: Bool
  public let isAcquaintanceBlockEnabled: Bool
  
  public init(
    isNotificationEnabled: Bool,
    isMatchNotificationEnabled: Bool,
    isAcquaintanceBlockEnabled: Bool
  ) {
    self.isNotificationEnabled = isNotificationEnabled
    self.isMatchNotificationEnabled = isMatchNotificationEnabled
    self.isAcquaintanceBlockEnabled = isAcquaintanceBlockEnabled
  }
}
