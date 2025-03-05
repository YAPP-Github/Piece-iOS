//
//  TokenRefreshResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/15/25.
//

import Entities
import Foundation

public struct TokenRefreshResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
}
