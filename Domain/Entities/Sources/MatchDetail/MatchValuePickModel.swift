//
//  MatchValuePickModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct MatchValuePickModel: Identifiable {
  public init(
    id: Int,
    description: String,
    nickname: String,
    valuePicks: [MatchValuePickItemModel]
  ) {
    self.id = id
    self.description = description
    self.nickname = nickname
    self.valuePicks = valuePicks
  }
  
  public let id: Int
  public let description: String
  public let nickname: String
  public let valuePicks: [MatchValuePickItemModel]
}
