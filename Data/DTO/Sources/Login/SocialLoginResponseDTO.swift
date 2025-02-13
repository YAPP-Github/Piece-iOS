//
//  SocialLoginResponseDTO.swift
//  DTO
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import Entities

public struct SocialLoginResponseDTO: Decodable {
  public let role: String
  public let accessToken: String
  public let refreshToken: String
}

public extension SocialLoginResponseDTO {
  func toDomain() -> SocialLoginResultModel {
    return SocialLoginResultModel(
      role: RoleType(rawValue: role) ?? .NONE,
      accessToken: accessToken,
      refreshToken: refreshToken
    )
  }
}
