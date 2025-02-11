//
//  ValueTalkModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct ValueTalkModel: Identifiable, Hashable {
  public init(
    id: Int,
    category: String,
    title: String,
    placeholder: String,
    guides: [String],
    answer: String? = nil
  ) {
    self.id = id
    self.category = category
    self.title = title
    self.placeholder = placeholder
    self.guides = guides
    self.answer = answer
  }
  
  public let id: Int
  public let category: String
  public let title: String
  public let placeholder: String
  public let guides: [String]
  public var answer: String?
}
