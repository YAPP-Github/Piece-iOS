//
//  UserRoleResponseDTO.swift
//  DTO
//
//  Created by eunseou on 3/1/25.
//

import Entities
import SwiftUI

public struct UserRoleResponseDTO: Decodable {
  public let userId: Int
  public let role: String
}

public extension UserRoleResponseDTO {
  func toDomain() -> UserRoleModel {
    return UserRoleModel(userId: userId, role: role)
  }
}
