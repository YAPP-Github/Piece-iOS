//
//  MatchValueTalkModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct MatchValueTalkModel: Identifiable {
  public init(
    id: Int,
    description: String,
    nickname: String,
    valueTalks: [ValueTalkModel]
  ) {
    self.id = id
    self.description = description
    self.nickname = nickname
    self.valueTalks = valueTalks
  }
  
  public let id: Int
  public let description: String
  public let nickname: String
  public let valueTalks: [ValueTalkModel]
}
