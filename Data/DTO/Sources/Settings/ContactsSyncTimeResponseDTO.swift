//
//  ContactsSyncTimeResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/19/25.
//

import Entities
import Foundation

public struct ContactsSyncTimeResponseDTO: Decodable {
  public let syncTime: Date
}

public extension ContactsSyncTimeResponseDTO {
  func toDomain() -> ContactsSyncTimeModel {
    ContactsSyncTimeModel(syncTime: syncTime)
  }
}
