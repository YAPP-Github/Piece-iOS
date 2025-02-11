//
//  ValuePickAnswerModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct ValuePickAnswerModel: Hashable, Identifiable {
  public init(number: Int, content: String) {
    self.id = number
    self.content = content
  }
  
  public let id: Int
  public let content: String
}
