//
//  UserRejectReasonResponseDTO.swift
//  DTO
//
//  Created by eunseou on 2/24/25.
//

import SwiftUI
import Entities

public struct UserRejectReasonResponseDTO: Decodable {
  public let profileStatus: String
  public let reasonImage: Bool
  public let reasonValues: Bool
}

public extension UserRejectReasonResponseDTO {
  func toDomain() -> UserRejectReasonModel {
    UserRejectReasonModel(
      profileStatus: profileStatus,
      reasonImage: reasonImage,
      reasonValues: reasonValues
    )
  }
}
