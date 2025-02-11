//
//  MatchValueTalksResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/11/25.
//

import Entities
import Foundation

public struct MatchValueTalksResponseDTO: Decodable {
  public let matchId: Int
  public let description: String
  public let nickname: String
  public let valueTalks: [MatchValueTalkResponseDTO]
}

public extension MatchValueTalksResponseDTO {
  func toDomain() -> MatchValueTalkModel {
    MatchValueTalkModel(
      id: matchId,
      description: description,
      nickname: nickname,
      valueTalks: valueTalks.map { $0.toDomain() }
    )
  }
}
