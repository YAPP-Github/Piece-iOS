//
//  SettingsInfoResponseDTO.swift
//  DTO
//
//  Created by summercat on 3/27/25.
//

import Entities
import Foundation

public struct SettingsInfoResponseDTO: Decodable {
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

public extension SettingsInfoResponseDTO {
  func toDomain() -> SettingsInfoModel {
    SettingsInfoModel(
      isNotificationEnabled: isNotificationEnabled,
      isMatchNotificationEnabled: isMatchNotificationEnabled,
      isAcquaintanceBlockEnabled: isAcquaintanceBlockEnabled
    )
  }
}
