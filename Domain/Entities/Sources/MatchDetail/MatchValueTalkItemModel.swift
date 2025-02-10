//
//  MatchValueTalkItemModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct MatchValueTalkItemModel {
  public let category: String
  public let summary: String
  public let answer: String
  
  public init(category: String, summary: String, answer: String) {
    self.category = category
    self.summary = summary
    self.answer = answer
  }
}
