//
//  SettingsNotificationRequestDTO.swift
//  DTO
//
//  Created by summercat on 3/27/25.
//

import Foundation

public struct SettingsNotificationRequestDTO: Encodable {
  public let toggle: Bool
  
  public init(toggle: Bool) {
    self.toggle = toggle
  }
}
