//
//  ProfileValueTalkRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/13/25.
//

import Foundation

public struct ProfileValueTalkRequestDTO: Encodable {
  public let profileValueTalkId: Int
  public let answer: String
  public let summary: String
  
  public init(
    profileValueTalkId: Int,
    answer: String,
    summary: String
  ) {
    self.profileValueTalkId = profileValueTalkId
    self.answer = answer
    self.summary = summary
  }
}
