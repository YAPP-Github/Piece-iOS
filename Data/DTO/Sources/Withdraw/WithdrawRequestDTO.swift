//
//  WithdrawRequestDTO.swift
//  DTO
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities

public struct WithdrawRequestDTO: Encodable {
  public let providerName: String
  public let oauthCredential: String
  public let reason: String
  
  public init(providerName: String, oauthCredential: String, reason: String) {
    self.providerName = providerName
    self.oauthCredential = oauthCredential
    self.reason = reason
  }
}
