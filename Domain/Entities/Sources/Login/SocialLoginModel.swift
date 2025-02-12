//
//  SocialLoginModel.swift
//  Entities
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI

public enum RoleType: String {
  case NONE
  case REGISTER
  case PENDING
  case USER
}

public struct SocialLoginModel {
  public let role: RoleType
  public let accessToken: String
  public let refreshToken: String
  
  public init(
    role: RoleType,
    accessToken: String,
    refreshToken: String
  ) {
    self.role = role
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
