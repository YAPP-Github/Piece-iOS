//
//  SocialLoginModel.swift
//  Entities
//
//  Created by eunseou on 2/13/25.
//

public struct SocialLoginModel: Encodable {
  public let providerName: SocialLoginType
  public let token: String
  
  public init(providerName: SocialLoginType, token: String) {
    self.providerName = providerName
    self.token = token
  }
}
