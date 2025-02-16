//
//  AISummaryModel.swift
//  Entities
//
//  Created by summercat on 2/16/25.
//

public struct AISummaryModel {
  public let profileValueTalkId: Int
  public let summary: String
  
  public init(profileValueTalkId: Int, summary: String) {
    self.profileValueTalkId = profileValueTalkId
    self.summary = summary
  }
}
