//
//  UserRoleModel.swift
//  Entities
//
//  Created by eunseou on 3/1/25.
//

import SwiftUI

public struct UserRoleModel {
  public let userId: Int
  public let role: String
  
  public init(userId: Int, role: String) {
    self.userId = userId
    self.role = role
  }
}
