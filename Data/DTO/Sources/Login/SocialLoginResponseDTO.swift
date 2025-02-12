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
  func toDomain() -> SocialLoginModel {
    return SocialLoginModel(
      role: role,
      accessToken: accessToken,
      refreshToken: refreshToken
    )
  }
}
