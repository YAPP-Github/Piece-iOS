//
//  ValueTalkModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

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
