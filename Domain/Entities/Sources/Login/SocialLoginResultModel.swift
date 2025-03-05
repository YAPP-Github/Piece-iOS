//
//  SocialLoginModel.swift
//  Entities
//
//  Created by eunseou on 2/7/25.
//

public struct SocialLoginResultModel {
  public let role: UserRole
  public let accessToken: String
  public let refreshToken: String
  
  public init(
    role: UserRole,
    accessToken: String,
    refreshToken: String
  ) {
    self.role = role
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
