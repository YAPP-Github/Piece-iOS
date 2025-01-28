//
//  MatchValueTalkModel.swift
//  Entities
//
//  Created by summercat on 1/28/25.
//

public struct MatchValueTalkModel {
  public init(
    id: Int,
    shortIntroduction: String,
    nickname: String,
    valueTalks: [ValueTalkModel]
  ) {
    self.id = id
    self.shortIntroduction = shortIntroduction
    self.nickname = nickname
    self.valueTalks = valueTalks
  }
  
  public let id: Int
  public let shortIntroduction: String
  public let nickname: String
  public let valueTalks: [ValueTalkModel]
}

public struct ValueTalkModel {
  public init(
    category: String,
    summary: String,
    answer: String
  ) {
    self.category = category
    self.summary = summary
    self.answer = answer
  }
  
  public let category: String
  public let summary: String
  public let answer: String
}
