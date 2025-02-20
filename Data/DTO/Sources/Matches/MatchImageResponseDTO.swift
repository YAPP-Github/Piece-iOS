//
//  MatchImageResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/20/25.
//

import Entities
import Foundation

public struct MatchImageResponseDTO: Decodable {
  public let imageUrl: String
}

public extension MatchImageResponseDTO {
  func toDomain() -> MatchImageModel {
    MatchImageModel(imageUri: imageUrl)
  }
}
