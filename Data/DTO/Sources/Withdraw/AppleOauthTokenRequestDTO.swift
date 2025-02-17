//
//  AppleOauthTokenRequestDTO.swift
//  DTO
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities

public struct AppleOauthTokenRequestDTO: Encodable {
  public let client_id: String
  public let client_secret: String
  public let grant_type: String
  public let code: String
  public let redirect_uri: String
}
