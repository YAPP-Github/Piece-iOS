//
//  VerifySMSResponseModel.swift
//  Entities
//
//  Created by summercat on 4/16/25.
//

public struct VerifySMSCodeResponseModel {
  public let role: UserRole?
  public let accessToken: String?
  public let refreshToken: String?
  public let isPhoneNumberDuplicated: Bool
  public let oauthProvider: SocialLoginType?
  
  public init(
    role: UserRole?,
    accessToken: String?,
    refreshToken: String?,
    isPhoneNumberDuplicated: Bool,
    oauthProvider: SocialLoginType?
  ) {
    self.role = role
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.isPhoneNumberDuplicated = isPhoneNumberDuplicated
    self.oauthProvider = oauthProvider
  }
}
