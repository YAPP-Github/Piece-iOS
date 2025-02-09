//
//  ValueTalkModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct ValueTalkModel {
  public init(
    id: Int,
    category: String,
    title: String,
    placeholder: String,
    guides: [String]
  ) {
    self.id = id
    self.category = category
    self.title = title
    self.placeholder = placeholder
    self.guides = guides
  }
  
  public let id: Int
  public let category: String
  public let title: String
  public let placeholder: String
  public let guides: [String]
}
