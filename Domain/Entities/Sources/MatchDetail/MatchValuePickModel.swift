//
//  MatchValuePickModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct MatchValuePickModel: Identifiable {
  public init(
    id: Int,
    shortIntroduction: String,
    nickname: String,
    valuePicks: [ValuePickModel]
  ) {
    self.id = id
    self.shortIntroduction = shortIntroduction
    self.nickname = nickname
    self.valuePicks = valuePicks
  }
  
  public let id: Int
  public let shortIntroduction: String
  public let nickname: String
  public let valuePicks: [ValuePickModel]
}
