//
//  FCMTokenRequestDTO.swift
//  DTO
//
//  Created by summercat on 3/6/25.
//

import Foundation

public struct FCMTokenRequestDTO: Encodable {
  public let token: String
  
  public init(token: String) {
    self.token = token
  }
}
