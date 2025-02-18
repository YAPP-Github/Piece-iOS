//
//  WithdrawRequestDTO.swift
//  DTO
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities

public struct WithdrawRequestDTO: Encodable {
  public let reason: String
  
  public init(reason: String) {
    self.reason = reason
  }
}
