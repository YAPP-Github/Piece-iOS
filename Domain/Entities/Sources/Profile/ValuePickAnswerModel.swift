//
//  ValuePickAnswerModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct ValuePickAnswerModel {
  public init(number: Int, content: String) {
    self.number = number
    self.content = content
  }
  
  public let number: Int
  public let content: String
}
