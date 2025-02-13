//
//  SocialLoginRequsetDTo.swift
//  DTO
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import Entities

public struct SocialLoginRequsetDTO: Encodable {
  public let providerName: SocialLoginType
  public let oauthCredential: String
  
  public init(providerName: SocialLoginType, token: String) {
    self.providerName = providerName
    self.oauthCredential = token
  }
}
