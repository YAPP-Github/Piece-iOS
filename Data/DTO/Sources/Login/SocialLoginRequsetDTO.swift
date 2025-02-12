//
//  SocialLoginRequsetDTo.swift
//  DTO
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI

public enum SocialLoginType: String, Encodable {
  case apple
  case kakao
  case google
}

public struct SocialLoginRequsetDTO: Encodable {
  public let providerName: SocialLoginType
  public let token: String
  
  public init(providerName: SocialLoginType, token: String) {
    self.providerName = providerName
    self.token = token
  }
}
