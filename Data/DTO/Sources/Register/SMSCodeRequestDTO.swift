//
//  SMSCodeRequestDTO.swift
//  DTO
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import Entities

public struct SMSCodeRequestDTO: Encodable {
  public let phoneNumber: String
  
  public init(phoneNumber: String) {
    self.phoneNumber = phoneNumber
  }
}
