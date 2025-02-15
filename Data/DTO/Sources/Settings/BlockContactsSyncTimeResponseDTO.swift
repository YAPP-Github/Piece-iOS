//
//  BlockContactsSyncTimeResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/16/25.
//

import Entities
import Foundation

public struct BlockContactsSyncTimeResponseDTO: Decodable {
  public let syncTime: Date
}

public extension BlockContactsSyncTimeResponseDTO {
  func toDomain() -> BlockContactsSyncTimeModel {
    BlockContactsSyncTimeModel(syncTime: syncTime)
  }
}
