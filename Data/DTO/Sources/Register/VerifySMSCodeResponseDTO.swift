//
//  VerifySMSCodeResponseDTO.swift
//  DTO
//
//  Created by summercat on 4/16/25.
//

import Entities

public struct VerifySMSCodeResponseDTO: Decodable {
  public let role: String?
  public let accessToken: String?
  public let refreshToken: String?
  public let isPhoneNumberDuplicated: Bool
  public let oauthProvider: String?
}

public extension VerifySMSCodeResponseDTO {
  func toDomain() -> VerifySMSCodeResponseModel {
    VerifySMSCodeResponseModel(
      role: UserRole(rawValue: role ?? ""),
      accessToken: accessToken,
      refreshToken: refreshToken,
      isPhoneNumberDuplicated: isPhoneNumberDuplicated,
      oauthProvider: SocialLoginType(rawValue: oauthProvider ?? "")
    )
  }
}
