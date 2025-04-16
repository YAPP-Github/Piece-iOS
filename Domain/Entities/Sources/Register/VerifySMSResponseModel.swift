//
//  VerifySMSResponseModel.swift
//  Entities
//
//  Created by summercat on 4/16/25.
//

public struct VerifySMSCodeResponseModel {
  public let role: UserRole?
  public let isPhoneNumberDuplicated: Bool
  public let oauthProvider: SocialLoginType?
  
  public init(
    role: UserRole?,
    isPhoneNumberDuplicated: Bool,
    oauthProvider: SocialLoginType?
  ) {
    self.role = role
    self.isPhoneNumberDuplicated = isPhoneNumberDuplicated
    self.oauthProvider = oauthProvider
  }
}
