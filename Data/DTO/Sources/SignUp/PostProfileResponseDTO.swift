//
//  PostProfileResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/9/25.
//

import Entities
import Foundation

public struct PostProfileResponseDTO: Decodable {
  public let role: String
  public let accessToken: String
  public let refreshToken: String
  
  public init(role: String, accessToken: String, refreshToken: String) {
    self.role = role
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}

public extension PostProfileResponseDTO {
  func toDomain() -> PostProfileResultModel {
    return PostProfileResultModel(
      role: role,
      accessToken: accessToken,
      refreshToken: refreshToken
    )
  }
}
