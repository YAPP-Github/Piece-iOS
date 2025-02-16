//
//  ProfileValueTalkAISummaryResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/16/25.
//

import Entities
import Foundation

public struct ProfileValueTalkAISummaryResponseDTO: Decodable {
  public let profileValueTalkId: Int
  public let summary: String
  
  public init(profileValueTalkId: Int, summary: String) {
    self.profileValueTalkId = profileValueTalkId
    self.summary = summary
  }
}

public extension ProfileValueTalkAISummaryResponseDTO {
  func toDomain() -> AISummaryModel {
    AISummaryModel(profileValueTalkId: profileValueTalkId, summary: summary)
  }
}
