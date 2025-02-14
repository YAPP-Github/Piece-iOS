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
  public var summary: String
  public var answer: String
  public let placeholder: String
  public let guides: [String]
  
  public init(
    id: Int,
    title: String,
    category: String,
    summary: String,
    answer: String,
    placeholder: String,
    guides: [String]
  ) {
    self.id = id
    self.title = title
    self.category = category
    self.summary = summary
    self.answer = answer
    self.placeholder = placeholder
    self.guides = guides
  }
}
