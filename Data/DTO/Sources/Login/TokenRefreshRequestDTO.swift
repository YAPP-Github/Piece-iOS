//
//  TokenRefreshRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/15/25.
//

import Entities
import Foundation

public struct TokenRefreshRequestDTO: Encodable {
  public let refreshToken: String
  
  public init(refreshToken: String) {
    self.refreshToken = refreshToken
  }
}
