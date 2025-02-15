//
//  SocialLoginTokenRefreshResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/15/25.
//

import Entities
import Foundation

public struct SocialLoginTokenRefreshResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
}
