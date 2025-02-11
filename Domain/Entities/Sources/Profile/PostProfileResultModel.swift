//
//  PostProfileResultModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct PostProfileResultModel {
  public init(role: String, accessToken: String, refreshToken: String) {
    self.role = role
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
  
  public let role: String
  public let accessToken: String
  public let refreshToken: String
}
