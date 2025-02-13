//
//  ProfileValueTalkModel.swift
//  Entities
//
//  Created by summercat on 2/13/25.
//

public struct ProfileValueTalkModel: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let category: String
  public let summary: String
  public let answer: String
  
  public init(
    id: Int,
    title: String,
    category: String,
    summary: String,
    answer: String
  ) {
    self.id = id
    self.title = title
    self.category = category
    self.summary = summary
    self.answer = answer
  }
}
