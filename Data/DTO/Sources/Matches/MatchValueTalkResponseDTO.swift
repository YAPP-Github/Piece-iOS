//
//  MatchValueTalkResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/11/25.
//

import Entities
import Foundation

public struct MatchValueTalkResponseDTO: Decodable {
  public let category: String
  public let summary: String
  public let answer: String
}

public extension MatchValueTalkResponseDTO {
  func toDomain() -> MatchValueTalkItemModel {
    MatchValueTalkItemModel(
      category: category,
      summary: summary,
      answer: answer
    )
  }
}

